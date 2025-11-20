-- ========================================
-- Table Role
-- ========================================
CREATE TABLE Role (
    IdRole INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(250) NULL
);

-- ========================================
-- Table Utilisateur
-- ========================================
CREATE TABLE Utilisateur (
    IdUtilisateur INT PRIMARY KEY IDENTITY(1,1),
    NomUtilisateur NVARCHAR(50) NOT NULL UNIQUE,
    MotDePasse NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    IdRole INT NOT NULL,
    CONSTRAINT FK_Utilisateur_Role FOREIGN KEY (IdRole)
        REFERENCES Role(IdRole)
);

-- ========================================
-- Table Departement
-- ========================================
CREATE TABLE Departement (
    IdDepartement INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- Table Poste
-- ========================================
CREATE TABLE Poste (
    IdPoste INT PRIMARY KEY IDENTITY(1,1),
    Titre NVARCHAR(100) NOT NULL,
    Description NVARCHAR(250) NULL,
    SalaireBase DECIMAL(10,2) NOT NULL
);

-- ========================================
-- Table Employe
-- ========================================
CREATE TABLE Employe (
    IdEmploye INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(50) NOT NULL,
    Prenom NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Telephone NVARCHAR(20) NULL,
    DateEmbauche DATE NOT NULL,
    Poste NVARCHAR(100) NULL,
    Salaire DECIMAL(10,2) NULL,
    IdUtilisateur INT NULL,
    IdDepartement INT NULL,
    IdPoste INT NULL,
    CONSTRAINT FK_Employe_Utilisateur FOREIGN KEY (IdUtilisateur)
        REFERENCES Utilisateur(IdUtilisateur),
    CONSTRAINT FK_Employe_Departement FOREIGN KEY (IdDepartement)
        REFERENCES Departement(IdDepartement),
    CONSTRAINT FK_Employe_Poste FOREIGN KEY (IdPoste)
        REFERENCES Poste(IdPoste)
);

-- ========================================
-- Table TypeConge
-- ========================================
CREATE TABLE TypeConge (
    IdTypeConge INT PRIMARY KEY IDENTITY(1,1),
    Libelle NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(250) NULL
);

-- ========================================
-- Table StatutConge
-- ========================================
CREATE TABLE StatutConge (
    IdStatutConge INT PRIMARY KEY IDENTITY(1,1),
    Libelle NVARCHAR(50) NOT NULL UNIQUE
);

-- ========================================
-- Table Conge
-- ========================================
CREATE TABLE Conge (
    IdConge INT PRIMARY KEY IDENTITY(1,1),
    DateDebut DATE NOT NULL,
    DateFin DATE NOT NULL,
    Motif NVARCHAR(250) NULL,
    IdEmploye INT NOT NULL,
    IdTypeConge INT NOT NULL,
    IdStatutConge INT NOT NULL,
    CONSTRAINT FK_Conge_Employe FOREIGN KEY (IdEmploye)
        REFERENCES Employe(IdEmploye),
    CONSTRAINT FK_Conge_TypeConge FOREIGN KEY (IdTypeConge)
        REFERENCES TypeConge(IdTypeConge),
    CONSTRAINT FK_Conge_StatutConge FOREIGN KEY (IdStatutConge)
        REFERENCES StatutConge(IdStatutConge)
);

-- ========================================
-- Table Absence
-- ========================================
CREATE TABLE Absence (
    IdAbsence INT PRIMARY KEY IDENTITY(1,1),
    DateAbsence DATE NOT NULL,
    Raison NVARCHAR(250) NULL,
    IdEmploye INT NOT NULL,
    CONSTRAINT FK_Absence_Employe FOREIGN KEY (IdEmploye)
        REFERENCES Employe(IdEmploye)
);

-- ========================================
-- Table Paie
-- ========================================
CREATE TABLE Paie (
    IdPaie INT PRIMARY KEY IDENTITY(1,1),
    Mois NVARCHAR(20) NOT NULL,
    Annee INT NOT NULL,
    SalaireBrut DECIMAL(10,2) NOT NULL,
    SalaireNet DECIMAL(10,2) NOT NULL,
    IdEmploye INT NOT NULL,
    CONSTRAINT FK_Paie_Employe FOREIGN KEY (IdEmploye)
        REFERENCES Employe(IdEmploye)
);

-- ========================================
-- Table RapportPDF
-- ========================================
CREATE TABLE RapportPDF (
    IdRapport INT PRIMARY KEY IDENTITY(1,1),
    DateGeneration DATETIME NOT NULL DEFAULT GETDATE(),
    TypeRapport NVARCHAR(50) NOT NULL,
    CheminFichier NVARCHAR(250) NOT NULL,
    IdEmploye INT NOT NULL,
    CONSTRAINT FK_RapportPDF_Employe FOREIGN KEY (IdEmploye)
        REFERENCES Employe(IdEmploye)
);

-- ========================================
-- Table Notification
-- ========================================
CREATE TABLE Notification (
    IdNotification INT PRIMARY KEY IDENTITY(1,1),
    Message NVARCHAR(250) NOT NULL,
    DateEnvoi DATETIME NOT NULL DEFAULT GETDATE(),
    EstLue BIT NOT NULL DEFAULT 0,
    IdEmploye INT NOT NULL,
    IdConge INT NULL,
    CONSTRAINT FK_Notification_Employe FOREIGN KEY (IdEmploye)
        REFERENCES Employe(IdEmploye),
    CONSTRAINT FK_Notification_Conge FOREIGN KEY (IdConge)
        REFERENCES Conge(IdConge)
);
