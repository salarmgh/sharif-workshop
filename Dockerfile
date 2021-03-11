FROM python:3.9.2 AS python


WORKDIR /app

COPY ["requirements.txt", "/app"]
RUN pip install -r requirements.txt

COPY [".", "/app"]

RUN python manage.py collectstatic

CMD uwsgi --socket :8000 --module workshop.wsgi

FROM nginx:1.18.0 AS nginx
COPY --from=python ["/app/workshop/static", "/app/static"]
