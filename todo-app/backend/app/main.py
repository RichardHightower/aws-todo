from fastapi import FastAPI
from app.core.config import settings
from app.api.routes import todo
from app.core.database import engine, Base
from fastapi.middleware.cors import CORSMiddleware

Base.metadata.create_all(bind=engine)

app = FastAPI(title=settings.PROJECT_NAME)

app.include_router(todo.router, prefix=f"{settings.API_V1_STR}/todo-items", tags=["todo-items"])

app.add_middleware(
    CORSMiddleware,
    allow_origins=[settings.BACKEND_CORS_ORIGIN],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"message": "Welcome to the Todo App API"}