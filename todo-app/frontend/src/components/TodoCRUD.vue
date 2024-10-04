<template>
  <div>
    <h2>Todo List</h2>

    <!-- Form for adding new todo items -->
    <form @submit.prevent="submitTodo">
      <input v-model="newTodo.name" placeholder="Name" required />
      <div>
        <textarea
          v-model="newTodo.description"
          placeholder="Description"
          rows="3"
        ></textarea>
      </div>
      <select v-model="newTodo.status">
        <option value="Not Done">Not Done</option>
        <option value="Hold">In Progress</option>
        <option value="Done">Done</option>
      </select>
      <button type="submit">Add Todo</button>
    </form>

    <!-- Table to display todo items -->
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="todo in todos" :key="todo.id">
          <td>{{ todo.name }}</td>
          <td>{{ todo.description }}</td>
          <td>{{ todo.status }}</td>
          <td>
            <a href="#" @click.prevent="editTodo(todo)">Edit</a> |
            <a href="#" @click.prevent="deleteTodo(todo.id)">Delete</a>
          </td>
        </tr>
      </tbody>
    </table>

    <!-- Edit modal (you can implement this as a separate component if preferred) -->
    <div v-if="editingTodo" class="modal">
      <h3>Edit Todo</h3>
      <form @submit.prevent="updateTodo">
        <input v-model="editingTodo.name" placeholder="Name" required />
        <input v-model="editingTodo.description" placeholder="Description" />
        <select v-model="editingTodo.status">
          <option value="Not Done">Not Done</option>
          <option value="In Progress">In Progress</option>
          <option value="Done">Done</option>
        </select>
        <button type="submit">Update</button>
        <button @click="cancelEdit">Cancel</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      todos: [],
      newTodo: {
        name: "",
        description: "",
        status: "Not Done",
      },
      editingTodo: null,
    };
  },
  mounted() {
    this.fetchTodos();
  },
  methods: {
    async fetchTodos() {
      try {
        const response = await axios.get(
          "http://localhost:8000/api/v1/todo-items/"
        );
        this.todos = response.data;
      } catch (error) {
        console.error("Error fetching todos:", error);
      }
    },
    async submitTodo() {
      try {
        await axios.post(
          "http://localhost:8000/api/v1/todo-items/",
          this.newTodo
        );
        this.newTodo = { name: "", description: "", status: "Not Done" };
        this.fetchTodos();
      } catch (error) {
        console.error("Error submitting todo:", error);
      }
    },
    editTodo(todo) {
      this.editingTodo = { ...todo };
    },
    async updateTodo() {
      try {
        await axios.put(
          `http://localhost:8000/api/v1/todo-items/${this.editingTodo.id}`,
          this.editingTodo
        );
        this.editingTodo = null;
        this.fetchTodos();
      } catch (error) {
        console.error("Error updating todo:", error);
      }
    },
    cancelEdit() {
      this.editingTodo = null;
    },
    async deleteTodo(id) {
      try {
        await axios.delete(`http://localhost:8000/api/v1/todo-items/${id}`);
        this.fetchTodos();
      } catch (error) {
        console.error("Error deleting todo:", error);
      }
    },
  },
};
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

th,
td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}

form {
  margin-bottom: 20px;
}

input,
select {
  margin-right: 10px;
  padding: 5px;
}

button {
  padding: 5px 10px;
  background-color: #4caf50;
  color: white;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

.modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 20px;
  border: 1px solid #ddd;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
</style>
