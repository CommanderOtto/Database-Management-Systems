CREATE DATABASE MovieDatabase;

GO

CREATE TABLE [dbo].[Director] (
    [EmployeeNumber] INT           IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [Gender]         NVARCHAR (10) NOT NULL,
    [YearOfBirth]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([EmployeeNumber] ASC)
);
GO

CREATE TABLE [dbo].[Movie] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [Type]           NVARCHAR (15) NOT NULL,
    [Language]       NVARCHAR (15) NOT NULL,
    [Year]           INT           NOT NULL,
    [MovieCompanyId] INT           NOT NULL,
    [DirectorId]     INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[MovieCompany] (
    [CompanyId]       INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName]     NVARCHAR (50) NOT NULL,
    [CountryOfOrigin] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CompanyId] ASC)
);
GO

CREATE TABLE [dbo].[Actor] (
    [EmployeeNumber] INT           IDENTITY (1, 1) NOT NULL,
    [MovieCompany]   INT           NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [Gender]         NVARCHAR (10) NOT NULL,
    [YearOfBirth]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([EmployeeNumber] ASC),
    CONSTRAINT [FK_Actor_MovieCompany] FOREIGN KEY ([MovieCompany]) REFERENCES [dbo].[MovieCompany] ([CompanyId])
);
GO

CREATE TABLE [dbo].[CompanyDirector] (
    [CompanyId]  INT NOT NULL,
    [DirectorId] INT NOT NULL,
    CONSTRAINT [FK_CompanyDirector_MovieCompany] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[MovieCompany] ([CompanyId]),
    CONSTRAINT [FK_CompanyDirector_Director] FOREIGN KEY ([DirectorId]) REFERENCES [dbo].[Director] ([EmployeeNumber])
);
GO

CREATE TABLE [dbo].[MovieActor] (
    [MovieId] INT NOT NULL,
    [ActorId] INT NOT NULL,
    CONSTRAINT [FK_MovieActor_Movie] FOREIGN KEY ([MovieId]) REFERENCES [dbo].[Movie] ([Id]),
    CONSTRAINT [FK_MovieActor_Actor] FOREIGN KEY ([ActorId]) REFERENCES [dbo].[Actor] ([EmployeeNumber])
);
GO


Insert INTO MovieCompany
VALUES 
('Pixar', 'USA'),
('LionsGate', 'USA'),
('21CenturyFox', 'USA'),
('DreamWorks', 'USA'),
('Universal', 'USA'),
('LucasFilm', 'USA'),
('BadRobot', 'USA'),
('Amblin', 'USA'),
('MGM', 'USA'),
('Disney', 'USA');
GO

Insert INTO Director
VALUES 
('George Lucas','Male',1944),
('Alfred Hitchcock','Male',1899),
('Stanley Kubrick','Male',1928),
('Woody Allen','Male',1935),
('David Lean','Male',1908),
('Orson Welles','Male',1915),
('William Wyler','Male',1902),
('Charlie Chaplin','Male',1889),
('Roman Polanski','Male',1933),
('Martin Scorcese','Male',1942),
('Smith','Male',1950);
GO

Insert INTO Movie
VALUES 
('Star Wars','fantasy','English',1977,6,1),
('Taxi Driver','Action','English',1976,5,10),
('The Pianist','Drama','English',2002,10,9),
('Modern Times','Comedy','English',1936,7,8),
('Ben Hur','Drama','English',1959,8,7),
('Citizen Kane','Drama','English',1941,8,6),
('Lawrence of Arabia','Drama','English',1962,2,5),
('Manhattan','Comedy','English',1979,5,4),
('Barry Lyndon','Drama','English',1975,3,3),
('The Birds','Horror','English',1963,1,2),
('SmithyMovie','Horror','English',1963,1,11);
GO

Insert INTO Actor
VALUES 
(1,'Harrison Ford','Male',1942),
(2,'Johnny Depp','Male',1963),
(2,'Tom hanks','Male',1956),
(5,'Robin Williams','Male',1951),
(3,'Al Pacino','Male',1940),
(4,'Meryl Streep','Male',1949),
(9,'Jennifer Lawrence','Male',1990),
(7,'Emma Stone','Male',1988),
(8,'Anne Hathaway','Male',1982),
(6,'Emma Watson','Male',1990),
(6,'Smith','Male',1950);
GO

Insert INTO MovieActor
VALUES 
(1,2),
(5,3),
(2,8),
(7,2),
(7,3),
(6,6),
(8,1),
(10,9),
(9,4),
(3,5),
(11,11),
(4,7);
GO

Insert INTO CompanyDirector
VALUES 
(3,3),
(5,3),
(3,4),
(5,6),
(7,4),
(4,3),
(7,9),
(8,7),
(7,3),
(6,8),
(10,10);
GO

CREATE VIEW Actors1957 AS
SELECT Name,YearOfBirth
FROM Actor
WHERE YearOfBirth <= 1957;
GO

CREATE VIEW MoviesFromLucasFilm AS
SELECT Movie.Name as MovieTitle, Movie.Year, MovieCompany.CompanyName, Director.Name as DirectorName
FROM Movie
INNER JOIN MovieCompany ON Movie.MovieCompanyId=MovieCompany.CompanyId
INNER JOIN Director ON Movie.DirectorId=Director.EmployeeNumber
WHERE CompanyName = 'LucasFilm'
AND Year = 1977;
GO

CREATE VIEW ActorDirector AS
SELECT Movie.Name as MovieTitle, Director.Name as DirectorName, Actor.Name as ActorName
FROM Movie
INNER JOIN Director ON Movie.DirectorId=Director.EmployeeNumber
INNER JOIN MovieActor ON Movie.Id=MovieActor.ActorId
INNER JOIN Actor ON MovieActor.ActorId=Actor.EmployeeNumber
WHERE Actor.Name=Director.Name





