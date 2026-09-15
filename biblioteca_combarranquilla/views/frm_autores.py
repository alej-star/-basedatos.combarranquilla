import tkinter as tk

class frm_autores:
    def __init__(self, parent):
        self.top = tk.Toplevel(parent)
        self.top.title("Gestión de Autores")
        self.top.geometry("500x400")
        tk.Label(self.top, text="Módulo de Autores", font=("Arial", 12, "bold")).pack(pady=20)