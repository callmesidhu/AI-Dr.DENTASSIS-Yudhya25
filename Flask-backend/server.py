from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "<div><h1 style='text-align: center;'><b>Dr.DENTASSIS</b></h1> <p>HOME/</p></div>"

if __name__ == '__main__':
    app.run(debug=True)
