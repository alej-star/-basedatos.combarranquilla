from database import obtener_conexion

class autores:
    def __init__(self, id_autor=None, nombre=None, nacionalidad=None):
        self.id_autor = id_autor
        self.nombre = nombre
        self.nacionalidad = nacionalidad

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM autores")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []