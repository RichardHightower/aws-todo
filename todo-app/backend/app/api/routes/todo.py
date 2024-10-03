from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app import crud, schemas
from app.core.database import get_db

router = APIRouter()


@router.post("/", response_model=schemas.TodoItem)
def create_todo_item(item: schemas.TodoItemCreate, db: Session = Depends(get_db)):
    return crud.create_todo_item(db=db, item=item)


@router.get("/", response_model=List[schemas.TodoItem])
def read_todo_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    todo_items = crud.get_todo_items(db, skip=skip, limit=limit)
    return todo_items


@router.get("/{todo_id}", response_model=schemas.TodoItem)
def read_todo_item(todo_id: int, db: Session = Depends(get_db)):
    db_item = crud.get_todo_item(db, todo_id=todo_id)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Todo item not found")
    return db_item


@router.put("/{todo_id}", response_model=schemas.TodoItem)
def update_todo_item(todo_id: int, item: schemas.TodoItemCreate, db: Session = Depends(get_db)):
    db_item = crud.update_todo_item(db, todo_id=todo_id, item=item)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Todo item not found")
    return db_item


@router.delete("/{todo_id}", response_model=schemas.TodoItem)
def delete_todo_item(todo_id: int, db: Session = Depends(get_db)):
    db_item = crud.delete_todo_item(db, todo_id=todo_id)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Todo item not found")
    return db_item
