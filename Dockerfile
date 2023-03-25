FROM python:3-slim

RUN apt-get update && apt-get install -y build-essential python3-dev && rm -rf /var/lib/apt/lists/*

#RUN useradd pvforecast

WORKDIR /pvforecast

COPY requirements.txt ./
# pycryptodomex 3.14 currently fails to compile for arm64
#RUN pip install --no-cache-dir --upgrade -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY PVForecast PVForecast
COPY PVForecasts.py .
COPY SolCastLight.py .

VOLUME /logs
VOLUME /config
COPY config.ini /config/config.ini

#USER pvforecast

CMD [ "python", "PVForecasts.py", "-c", "/config/config.ini" ]
