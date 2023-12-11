
					document.addEventListener('DOMContentLoaded', function() {
						var user = localStorage.getItem('user');
						if (user) {
							document.querySelector('#loginButton').textContent = '로그아웃';
							document.querySelector('#loginButton').href = '#'; // 로그아웃 기능으로 변경
							document.querySelector('#loginButton').addEventListener('click', function(e) {
								e.preventDefault();
								localStorage.removeItem('user');
								location.reload();
							});
						}
					});
					