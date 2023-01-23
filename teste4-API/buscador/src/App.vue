<template>
  <div class="container">
    <div class="jumbotron d-flex flex-column mx-4 my-4">
      <h1 class="display-4">Operadoras</h1>
      <p class="lead">Busque as informações sobre as operadoras ativas aqui.</p>
      <div class="form-group mb-3">
        <label for="query">Buscar:</label>
        <input type="text" v-model="query" id="query" class="form-control" placeholder="Digite a busca">
        <button @click="search" class="btn btn-primary mx-2 my-2">Pesquisar</button>
      </div>
    </div>
    <div class="table-container mx-4 my-4">
      <h3 class="display-6">Resultados:</h3>
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th v-for="header in headers" :key="header">{{ header }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="result in results" :key="result.id">
              <td v-for="header in headers" :key="header">{{ result[header] }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
const axios = require('axios');

export default {
  data() {
    return {
      query: '',
      results: [],
      headers: []
    }
  },
  methods: {
    async search() {
      const response = await axios.get(`http://localhost:5000/buscar?query=${this.query}`)
      console.log(response.data)
      this.results = response.data
      this.headers = Object.keys(this.results[0])
    }
  },
}
</script>
