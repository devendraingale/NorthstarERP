FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000 \
    NORTHSTAR_DB=/data/northstar.sqlite3
WORKDIR /app
RUN useradd --uid 10001 --create-home app && mkdir -p /data && chown -R app:app /app /data
COPY --chown=app:app backend/ ./backend/
COPY --chown=app:app frontend/ ./frontend/
USER app
EXPOSE 8000
HEALTHCHECK --interval=20s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/api/health', timeout=2)" || exit 1
CMD ["python", "backend/server.py"]
