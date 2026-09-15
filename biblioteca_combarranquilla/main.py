"""
Biblioteca Combarranquilla - Sistema de Gestión

Punto de entrada principal de la aplicación.
Ejecutar con: python main.py

Credenciales de prueba por defecto:
- Usuario:    admin
- Contraseña: admin123
"""

from dashboard import Dashboard
from database import init_db
from login_window import LoginWindow


def iniciar_dashboard():
    """Inicia la ventana principal (Dashboard) al completar el login."""
    app_dashboard = Dashboard()
    app_dashboard.mainloop()


if __name__ == "__main__":
    # 1. Crea la base de datos y siembra los datos iniciales si no existen
    init_db()

    # 2. Inicia la ventana de login pasando la función de éxito
    login_window = LoginWindow(on_success=iniciar_dashboard)
    login_window.mainloop()