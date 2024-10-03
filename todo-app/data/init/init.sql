-- Create enum for task status
CREATE TYPE task_status AS ENUM ('Done', 'Hold', 'Not Done');

-- Create table for TODO items
CREATE TABLE todo_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status task_status NOT NULL DEFAULT 'Not Done',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index on status for faster querying
CREATE INDEX idx_todo_items_status ON todo_items(status);

-- Create function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update the updated_at timestamp
CREATE TRIGGER update_todo_item_modtime
    BEFORE UPDATE ON todo_items
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();
