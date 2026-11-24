FROM python:3.13-slim
WORKDIR /app

# TODO 1: requirements primeiro (aproveita a cache de camadas)
COPY requirements.txt .
# TODO 2
RUN pip install --no-cache-dir -r requirements.txt
# TODO 3
COPY app.py .
# TODO 4: utilizador sem privilegios + /data com escrita
RUN useradd --system --create-home appuser \
    && mkdir -p /data \
    && chown appuser:appuser /data
# TODO 5
USER appuser

EXPOSE 8000
CMD ["python", "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
