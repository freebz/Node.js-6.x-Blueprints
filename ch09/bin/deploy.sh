#!/bin/bash
set -o errexit # 오류 발생 시 종료
npm run build # 자바스크리븥와 CSS의 번들 생성
git push heroku master # 헤로쿠에 배포
