from database import obtener_conexion

class libros:
    def __init__(self, id_libro=None, titulo=None, id_autor=None, id_categoria=None):
        self.id_libro = id_libro
        self.titulo = titulo
        self.id_autor = id_autor
        self.id_categoria = id_categoria

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM libros")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []