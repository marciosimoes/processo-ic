from flask import Flask, jsonify, request
import mysql.connector as mysql

app = Flask(__name__)

conn = mysql.connect(
    host='localhost',
    user='root',
    password='',
    database='psintutivecare')
    
cursor = conn.cursor()

def check_query(query):
    if not query:
        return jsonify([{"erro" : "O parametro query está vazio."}])
    return query

def execute_query(query):
    sql_query = f"SELECT * FROM operadoras_ativas \
        WHERE registro_ans LIKE '%{query}%' \
        OR cnpj LIKE '%{query}%' \
        OR razao_social LIKE '%{query}%' \
        OR nome_fantasia LIKE '%{query}%'"

    cursor.execute(sql_query)
    return cursor.fetchall()

def jsonify_result(results):
    if not results:
        return jsonify([{"erro" : "Nenhum resultado encontrado."}])
    row_headers = [h[0] for h in cursor.description]
    json_data = []
    for result in results:
        json_data.append(dict(zip(row_headers,result)))
    return jsonify(json_data)

@app.route('/buscar', methods=['GET'])
def buscar():
    query = request.args.get('query')
    query = check_query(query)
    results = execute_query(query)
    return jsonify_result(results)
