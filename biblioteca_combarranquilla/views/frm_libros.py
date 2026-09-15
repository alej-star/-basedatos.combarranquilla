import tkinter as tk

class frm_libros:
    def __init__(self, parent):
        self.top = tk.Toplevel(parent)
        self.top.title("Gestión de Libros")
        self.top.geometry("500x400")
        tk.Label(self.top, text="Módulo de Libros", font=("Arial", 12, "bold")).pack(pady=20)