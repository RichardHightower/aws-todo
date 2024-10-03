from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class TodoItemBase(BaseModel):
    name: str
    description: Optional[str] = None
    status: str = "Not Done"


class TodoItemCreate(TodoItemBase):
    pass


class TodoItem(TodoItemBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True
