FROM python:3-alpine

WORKDIR /app
EXPOSE 5000
STOPSIGNAL SIGINT

COPY requirements.txt app.py ./
RUN pip install -r requirements.txt

CMD flask run -h 0.0.0.0
