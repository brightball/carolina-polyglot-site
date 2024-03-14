from flask import Flask
import psycopg
import os
from flask import jsonify

app = Flask(__name__)

@app.route('/ping')
def ping():
  conn = psycopg.connect(
    host='pgbouncer',
    user='backend',
    password=os.environ['DB_PASSWORD'],
    dbname='ccc',
    port=6432
  )
  cur = conn.cursor()
  cur.execute('SELECT version()')
  record = cur.fetchone()

  return jsonify(
    backend='python-flask',
    db_version=record[0]
  )

if __name__ == "__main__":
  app.run(debug=True)





