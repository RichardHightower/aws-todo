from datetime import datetime

from sqlalchemy.orm import Session
from app.schemas.schemas import TodoItemCreate, TodoItem
from app.models.models import TodoItem as TodoItemModel


def get_todo_item(db: Session, todo_id: int):
    return db.query(TodoItemModel).filter(TodoItemModel.id == todo_id).first()


def get_todo_items(db: Session, skip: int = 0, limit: int = 100):
    return db.query(TodoItemModel).offset(skip).limit(limit).all()


def create_todo_item(db: Session, item: TodoItemCreate):
    db_item = TodoItemModel(**item.dict())
    db_item.created_at = datetime.utcnow()
    db_item.updated_at = datetime.utcnow()
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item


def update_todo_item(db: Session, todo_id: int, item: TodoItemCreate):
    db_item = get_todo_item(db, todo_id)
    if db_item:
        for key, value in item.dict().items():
            setattr(db_item, key, value)
        db.commit()
        db.refresh(db_item)
    db_item.updated_at = datetime.utcnow()
    return db_item


def delete_todo_item(db: Session, todo_id: int):
    db_item = get_todo_item(db, todo_id)
    if db_item:
        db.delete(db_item)
        db.commit()
    return db_item