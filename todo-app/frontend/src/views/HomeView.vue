<template>
  <div class="home">
    <img
      alt="Vue logo"
      src="../assets/logo.png"
      style="width: 100px; height: auto"
    />
    <TodoCRUD />
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import TodoCRUD from "@/components/TodoCRUD.vue"; // @ is an alias to /src

@Options({
  components: {
    TodoCRUD,
  },
})
export default class HomeView extends Vue {}
</script>
