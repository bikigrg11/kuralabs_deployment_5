FROM python:3.8

WORKDIR /app
ADD ./app /app/

RUN apt update
RUN pip3 install -r requirements.txt
RUN pip install gunicorn

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]