from flask import Flask, jsonify
from configs.dbconnection import db_connection

app = Flask(__name__)

@app.route('/')
def home():
    return "<div><h1 style='text-align: center;'><b>Dr.DENTASSIS</b></h1><p>HOME/</p></div>"


@app.route('/db')
def test_db():
    conn = db_connection()
    if conn:
        return jsonify({"status": "Database connected!"})
    return jsonify({"status": "Database connection failed!"})

if __name__ == '__main__':
    app.run(debug=True)
    