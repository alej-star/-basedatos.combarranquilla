from database import obtener_conexion

class categorias:
    def __init__(self, id_categoria=None, nombre=None):
        self.id_categoria = id_categoria
        self.nombre = nombre

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM categorias")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []