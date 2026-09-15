import tkinter as tk

class frm_categorias:
    def __init__(self, parent):
        self.top = tk.Toplevel(parent)
        self.top.title("Gestión de Categorías")
        self.top.geometry("500x400")
        tk.Label(self.top, text="Módulo de Categorías", font=("Arial", 12, "bold")).pack(pady=20)