const express = require('express');
const path = require('path'); // path 모듈 임포트
const oracledb = require('oracledb');
const bodyParser = require('body-parser');
const session = require('express-session');

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: true }
  }));

// URL-encoded 데이터 처리 (Form 데이터 처리)
app.use(bodyParser.urlencoded({ extended: true }));

// 정적 파일 제공 설정 (index.html 포함)
app.use(express.static('public'));

// Oracle 데이터베이스 연결 설정
const dbConfig = {
    user: 'c##scott',
    password: 'tiger',
    connectString: 'localhost:1521/xe'
};


//로그인 기능
app.post('/login', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const { email, passwd } = req.body;

        const sql = `SELECT * FROM users WHERE email = :email AND passwd = :passwd`;
        const result = await connection.execute(sql, [email, passwd], { outFormat: oracledb.OUT_FORMAT_OBJECT });

        if (result.rows.length > 0) {
            // 로그인 성공 처리
            req.session.user = result.rows[0];
            res.json({ message: 'Login successful', user: result.rows[0] });
        } else {
            // 로그인 실패 처리
            res.status(401).json({ message: 'Invalid email or password' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error logging in' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

//회원등록 기능
app.post('/register', async (req, res) => {
    let connection;
    
    try {
        connection = await oracledb.getConnection(dbConfig);
        const { name, email, phone, birth, address, passwd } = req.body;
        const sql = `INSERT INTO users (name, email, phone, birth, address, passwd) VALUES (:name, :email, :phone, :birth, :address, :passwd)`;

        const result = await connection.execute(sql, [name, email, phone, birth, address, passwd], { autoCommit: true });
        // 처리 완료 후 리디렉션
     res.redirect('/signup_done.html');
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error registering user' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

//예약하기
app.post('/reserve', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const {
            reservation_id,
            customer_id,
            hotel_id,
            customer_name,
            room_type,
            number_of_guests,
            start_date,
            end_date
        } = req.body;
        const reservation_status = 'Reserved'; // 예약 상태를 'Reserved'로 설정
        const room_price = parseInt(req.body.room_price);

        // 데이터베이스에 예약 정보 삽입
        const sql = `
            INSERT INTO reservation_info 
            (reservation_id, customer_id, hotel_id, room_price, customer_name, room_type, number_of_guests, start_date, end_date, reservation_status) 
            VALUES 
            (:reservation_id, :customer_id, :hotel_id, :room_price, :customer_name, :room_type, :number_of_guests, TO_DATE(:start_date, 'YYYY-MM-DD'), TO_DATE(:end_date, 'YYYY-MM-DD'), :reservation_status)`;

        const result = await connection.execute(sql, {
            reservation_id, // UUID 사용
            customer_id,
            hotel_id,
            room_price,
            customer_name,
            room_type,
            number_of_guests,
            start_date,
            end_date,
            reservation_status
        }, { autoCommit: true });

        res.redirect('/h_reservation_done.html')
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error making reservation' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// 부대시설 예약 처리
app.post('/reserve-facility', async (req, res) => {
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        const {
            f_ReservationID,
            CustomerName,
            Hotelname,
            Reservationprice,
            FacilityType,
            NumberOfPeople,
            StartDate,
            EndDate,
            ReservationStatus
        } = req.body;

        const sql = `
            INSERT INTO FacilityReservation
            (f_ReservationID,CustomerName, Hotelname,Reservationprice, FacilityType, NumberOfPeople, StartDate, EndDate, ReservationStatus) 
            VALUES 
            (:f_ReservationID,:CustomerName, :Hotelname, :Reservationprice, :FacilityType, :NumberOfPeople, TO_DATE(:StartDate, 'YYYY-MM-DD'), TO_DATE(:EndDate, 'YYYY-MM-DD'), :ReservationStatus)`;

        await connection.execute(sql, {
            f_ReservationID,
            CustomerName,
            Hotelname,
            Reservationprice,
            FacilityType,
            NumberOfPeople,
            StartDate,
            EndDate,
            ReservationStatus
        }, { autoCommit: true });

        res.redirect('/h_reservation_done.html')
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error processing facility reservation' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// 루트 경로에 대한 요청을 처리하는 라우트 핸들러 추가
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/auth/status', (req, res) => {
    const isLoggedIn = req.session && req.session.user; // 세션에 사용자 정보가 있는지 확인
    res.json({ isLoggedIn: !!isLoggedIn });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});