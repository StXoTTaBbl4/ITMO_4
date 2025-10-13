# Secure API — учебный проект

## Описание
Учебный REST API на Flask для ЛР1 по предмету 'Информационная безопасность' с аутентификацией через JWT, хранением данных в SQLite, мерами защиты от OWASP Top 10 и интеграцией security-сканеров в CI.

## Эндпоинты
- `POST /auth/register` — регистрация (json: {"username":"...","password":"..."})

```bash
curl -X POST http://127.0.0.1:5000/auth/register ^ -H "Content-Type: application/json" ^ -d "{\"username\":\"user1\",\"password\":\"secret\"}"
```

- `POST /auth/login` — получение JWT (json: {"username":"...","password":"..."})
```bash
curl -X POST http://localhost:5000/auth/login ^ -H "Content-Type: application/json" -d "{\"username\":\"user1\",\"password\":\"secret\"}"
```
- `GET /api/data` — защищённый эндпоинт, требует заголовок `Authorization: Bearer <token>`

```bash
curl -H "Authorization: Bearer <token>" http://localhost:5000/api/data
```

## Описание реализованных мер защиты

### SQLi

Реализуется посредством использования SQLAlchemy при инициализации БД, и использовании ее ORM методов для запросов к БД
```python
# models.py
db = SQLAlchemy()

# app.py
user = User(username=username, password_hash=hash_password(password))
db.session.add(user)
db.session.commit()
```

### XSS

Для предотвращения XSS перед отправкой ответа от API, все данные оборачиваются в escape()
```python
def get_data(payload):
    users = User.query.all()
    result = []
    for u in users:
        result.append({
            "id": u.id,
            "username": escape(u.username), # <- вот тут
            "created_at": u.created_at.isoformat()
        })
    return jsonify(result)
```

## Скриншот отчета SAST
![SAST](./images/SAST.png)

## Скриншот отчета SCA 
<span style="color: red">ВАЖНО</span>
pip-audit находит одну [уязвимость](https://github.com/pypa/pip/pull/13550) - она пока не исправлена ни в одной номерной версии pip, и запланирована в версии 25.3 

Цитата из сообщения об уязвимости:
>The [fix](https://github.com/pypa/pip/pull/13550), while available as a patch that can be manually applied, has not yet been put into a numbered version but is planned for `25.3`

![SCA](./images/SCA.png)

## Запуск
```bash
python -m venv venv
#source venv/bin/activate <- linux
venv\Scripts\activate
pip install -r req.txt
export FLASK_APP=app.py
export FLASK_ENV=development
export SECRET_KEY="change_me_harder"
flask run
```