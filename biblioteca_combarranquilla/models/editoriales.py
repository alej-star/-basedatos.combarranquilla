from database import obtener_conexion

class editoriales:
    def __init__(self, id_editorial=None, nombre=None):
        self.id_editorial = id_editorial
        self.nombre = nombre

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM editoriales")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []