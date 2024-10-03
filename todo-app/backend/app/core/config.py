from pydantic_settings import BaseSettings
from dotenv import load_dotenv
import os

load_dotenv()


class Settings(BaseSettings):
    # Database settings
    DB_HOST: str = os.getenv("DB_HOST", "localhost")
    DB_PORT: str = os.getenv("DB_PORT", "5432")
    DB_NAME: str = os.getenv("DB_NAME", "todo_db")
    DB_USER: str = os.getenv("DB_USER", "dbuser")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD", "")

    # API settings
    API_V1_STR: str = "/api/v1"
    PROJECT_NAME: str = "Todo App API"

    # CORS settings
    BACKEND_CORS_ORIGIN: str = os.getenv("BACKEND_CORS_ORIGIN", "http://localhost:8081")

    class Config:
        case_sensitive = True


settings = Settings()