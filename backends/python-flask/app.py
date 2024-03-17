from flask import Flask
from psycopg import connect
import os
from flask import jsonify

conn = connect(
  host=os.environ.get('DB_HOST', '127.0.0.1'),
  port=os.environ.get('DB_PORT', 5432),
  dbname=os.environ['DB_NAME'],
  user=os.environ.get('DB_USERNAME', 'postgres'),
  password=os.environ['DB_PASSWORD'],
)

app = Flask(__name__)

@app.route('/ping')
def ping():
  with conn.cursor() as cur:
    cur.execute('SELECT version()')
    record = cur.fetchone()

    return jsonify(db_version=record[0])

@app.after_request
def add_header(response):
  response.headers['X-Backend'] = 'python-flask'
  return response

if __name__ == "__main__":
  app.run(debug=True)
