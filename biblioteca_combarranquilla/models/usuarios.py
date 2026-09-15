from database import obtener_conexion

class usuarios:
    def __init__(self, id_usuario=None, nombre=None, email=None, telefono=None):
        self.id_usuario = id_usuario
        self.nombre = nombre
        self.email = email
        self.telefono = telefono

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM usuarios")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []