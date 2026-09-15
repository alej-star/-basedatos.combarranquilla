from database import obtener_conexion

class prestamos:
    def __init__(self, id_prestamo=None, id_usuario=None, id_libro=None, fecha_prestamo=None):
        self.id_prestamo = id_prestamo
        self.id_usuario = id_usuario
        self.id_libro = id_libro
        self.fecha_prestamo = fecha_prestamo

    def obtener_todos(self):
        conexion = obtener_conexion()
        if conexion:
            cursor = conexion.cursor(dictionary=True)
            cursor.execute("SELECT * FROM prestamos")
            resultados = cursor.fetchall()
            conexion.close()
            return resultados
        return []