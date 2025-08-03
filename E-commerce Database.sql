USE Ecommerce

-- 22 Februari 2024 
DROP TABLE MasterProduk

CREATE TABLE MasterProduk(
	Id_ecommerce VARCHAR(100) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
	Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
	Id_produk VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
	Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
	Nama_toko VARCHAR(50)
);

DROP TABLE KategoriProduk

CREATE TABLE KategoriProduk (
	Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
	Kategori_barang VARCHAR(40)
);

DROP TABLE kota

CREATE TABLE Kota (
	Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
	Nama_kota VARCHAR(50)
);

DROP TABLE Produk

CREATE TABLE Produk (
	Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
	Id_ecommerce VARCHAR(100) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
	Id_toko VARCHAR(100) CONSTRAINT FK_Toko_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
	Nama_produk VARCHAR(100),
	Harga FLOAT,
	Diskon INT,
	Lokasi VARCHAR(100),
	Rating FLOAT,
	Terjual VARCHAR(100)
);

CREATE TABLE E_commerce (
	Id_ecommerce VARCHAR(1000) PRIMARY KEY NOT NULL,
	Nama_ecommerce VARCHAR (25)
);

DROP TABLE E_commerce

DROP TABLE Trending

CREATE TABLE Trending (
	Id_keyword INT PRIMARY KEY NOT NULL,
	Frekuensi_pencarian INT,
	Topik_produk VARCHAR(100),
	Waktu_tren DATE,
	Keyword_barang VARCHAR(50)
);

-- 26 Februari 2024 penambahan 1 table untuk menampung nama E-commerce

DROP TABLE E_commerce

CREATE TABLE E_commerce (
	Id_ecommerce VARCHAR(100) PRIMARY KEY NOT NULL,
	Nama_ecommerce VARCHAR (25)
);

-- 2 Maret 2024 penambahan 1 table untuk menampung nama toko dari produk

DROP TABLE Toko

CREATE TABLE Toko (
	Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
	Id_ecommerce VARCHAR(100) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
	Nama_toko VARCHAR (25)
);

select * from MasterProduk
order by Id_produk 

-- Menambahkan label tambahan pada kolumn Id_produk dengan label TP yang bearti Tokped
UPDATE Produk
SET Id_Produk = CONCAT('TP00', RIGHT('000' + CAST(Id_Produk AS VARCHAR(3)), 3));

-- Mengubah isi pada kolumn diskon untuk yang tidak ada diskon agar bernilai '0'
UPDATE Produk
SET Diskon = 0
WHERE Diskon IS NULL;

UPDATE Produk
SET Rating = 0
WHERE Rating IS NULL;

-- Menambahkan koma pada nomor Rating
UPDATE Produk
SET Rating = Rating / 10
WHERE Rating IS NOT NULL;

-- 13 Maret 2024
--> KategoriProduk -> Kota -> E_commerce -> Toko -> Produk -> MasterProduk

	CREATE TABLE MasterProduk(
		Id_ecommerce VARCHAR(100) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
		Id_produk VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
		Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
	);

	CREATE TABLE E_commerce (
		Id_ecommerce VARCHAR(100) PRIMARY KEY NOT NULL,
		Nama_ecommerce VARCHAR (25)
	);

	CREATE TABLE Toko (
		Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(100) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Nama_toko VARCHAR (25),
		Jam_operasi VARCHAR (50),
		Rating_toko FLOAT,
		Berdiri_sejak VARCHAR (50),
		Pesanan_proses DATETIMEOFFSET
	);

	CREATE TABLE KategoriProduk (
		Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Kategori_barang VARCHAR(30)
	);


	CREATE TABLE Produk (
		Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(100) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_toko VARCHAR(100) CONSTRAINT FK_Produk_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
		Nama_produk VARCHAR(100),
		Harga FLOAT,
		Diskon INT,
		Lokasi VARCHAR(100),
		Rating FLOAT,
		Terjual VARCHAR(100)
	);

	CREATE TABLE Kota (
		Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
		Nama_kota VARCHAR(50)
	);


-- 27 Maret 2024
--> SubkategoriProduk -> KategoriProduk -> Kota -> Provinsi -> E_commerce -> Toko -> Produk -> MasterProduk
	USE Ecommerce

	CREATE TABLE E_commerce (
		Id_ecommerce VARCHAR(10) PRIMARY KEY NOT NULL,
		Nama_ecommerce VARCHAR (25)
	);

	CREATE TABLE Kota (
		Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_provinsi VARCHAR(20) CONSTRAINT Fk_Kota_Id_provinsi REFERENCES Provinsi(Id_provinsi),
		Nama_kota VARCHAR(50)
	);
	
	CREATE TABLE Provinsi(
		Id_provinsi VARCHAR(20) PRIMARY KEY NOT NULL,
		Nama_provinsi VARCHAR(30)
	);

	CREATE TABLE KategoriProduk (
		Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Kategori_barang VARCHAR(30)
	);

	CREATE TABLE SubKategoriProduk(
		Id_subkategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_SubKategoriProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori), 
		Subkategori_barang VARCHAR(50)
	);

	CREATE TABLE Toko (
		Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Nama_toko VARCHAR (20),
		Jam_operasi VARCHAR (25),
		Rating_toko FLOAT,
		Pesanan_proses VARCHAR(25)
	);
	
	CREATE TABLE Produk (
		Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_toko VARCHAR(100) CONSTRAINT FK_Produk_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
		Id_kota VARCHAR(20) CONSTRAINT FK_Produk_Id_kota REFERENCES Kota(Id_kota) NOT NULL,
		Nama_produk VARCHAR(100),
		Harga FLOAT,
		Diskon INT,
		Rating FLOAT,
		Terjual VARCHAR(100)
	);

	CREATE TABLE MasterProduk(
		Id_ecommerce VARCHAR(10) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
		Id_subkategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_subkategori REFERENCES SubKategoriProduk(Id_subkategori),
		Id_toko VARCHAR(100) CONSTRAINT FK_MasterProduk_Id_toko REFERENCES Toko(Id_toko),
		Id_produk VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
		Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
		Id_provinsi VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_provinsi REFERENCES Provinsi(Id_provinsi)
	);

	ALTER TABLE Toko
	ALTER COLUMN Nama_toko VARCHAR(100);

	ALTER TABLE Produk
	ALTER COLUMN Harga VARCHAR(10);

	ALTER TABLE Produk
	ALTER COLUMN Diskon VARCHAR(5);


-- 5 April 2024
--> SubkategoriProduk -> KategoriProduk -> Kota -> Provinsi -> E_commerce -> Toko -> Produk -> MasterProduk
	USE Ecommerce

	CREATE TABLE E_commerce (
		Id_ecommerce VARCHAR(10) PRIMARY KEY NOT NULL,
		Nama_ecommerce VARCHAR(25) NOT NULL
	);

	CREATE TABLE Kota (
		Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_provinsi VARCHAR(20) CONSTRAINT Fk_Kota_Id_provinsi REFERENCES Provinsi(Id_provinsi),
		Nama_kota VARCHAR(50)
	);
	
	CREATE TABLE Provinsi(
		Id_provinsi VARCHAR(20) PRIMARY KEY NOT NULL,
		Nama_provinsi VARCHAR(30)
	);

	CREATE TABLE KategoriProduk (
		Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Kategori_barang VARCHAR(30)
	);

	CREATE TABLE SubKategoriProduk(
		Id_subkategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_SubKategoriProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori), 
		Subkategori_barang VARCHAR(50)
	);

	CREATE TABLE Toko (
		Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Nama_toko VARCHAR (100),
		Jam_operasi VARCHAR (25),
		Rating_toko FLOAT,
		Pesanan_proses VARCHAR(25)
	);
	
	CREATE TABLE Produk (
		Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_toko VARCHAR(100) CONSTRAINT FK_Produk_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
		Id_kota VARCHAR(20) CONSTRAINT FK_Produk_Id_kota REFERENCES Kota(Id_kota) NOT NULL,
		Id_subkategori VARCHAR(20) CONSTRAINT FK_Produk_Id_subkategori REFERENCES SubkategoriProduk(Id_subkategori) NOT NULL,
		Nama_produk VARCHAR(100),
		Harga VARCHAR(10),
		Diskon VARCHAR(5),
		Rating FLOAT,
		Terjual VARCHAR(100)
	);

	CREATE TABLE MasterProduk(
		Id_ecommerce VARCHAR(10) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
		Id_subkategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_subkategori REFERENCES SubKategoriProduk(Id_subkategori),
		Id_toko VARCHAR(100) CONSTRAINT FK_MasterProduk_Id_toko REFERENCES Toko(Id_toko),
		Id_produk VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
		Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
		Id_provinsi VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_provinsi REFERENCES Provinsi(Id_provinsi)
	);

-- 14 April 2024
--> SubkategoriProduk -> KategoriProduk -> Kota -> Provinsi -> E_commerce -> Toko -> Produk -> MasterProduk
	USE Ecommerce

	CREATE TABLE E_commerce (
		Id_ecommerce VARCHAR(10) PRIMARY KEY NOT NULL,
		Nama_ecommerce VARCHAR(25) NOT NULL
	);

	CREATE TABLE Kota (
		Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_provinsi VARCHAR(20) CONSTRAINT Fk_Kota_Id_provinsi REFERENCES Provinsi(Id_provinsi),
		Nama_kota VARCHAR(50) NOT NULL
	);
	
	CREATE TABLE Provinsi(
		Id_provinsi VARCHAR(20) PRIMARY KEY NOT NULL,
		Nama_provinsi VARCHAR(30) NOT NULL
	);

	CREATE TABLE KategoriProduk (
		Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Kategori_barang VARCHAR(30) NOT NULL
	);

	CREATE TABLE SubKategoriProduk(
		Id_subkategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_SubKategoriProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori), 
		Subkategori_barang VARCHAR(50) NOT NULL
	);

	CREATE TABLE Toko (
		Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Nama_toko VARCHAR (100),
		Jam_operasi VARCHAR (25),
		Rating_toko FLOAT,
		Pesanan_proses VARCHAR(25)
	);
	
	CREATE TABLE Produk (
		Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_toko VARCHAR(100) CONSTRAINT FK_Produk_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
		Id_kota VARCHAR(20) CONSTRAINT FK_Produk_Id_kota REFERENCES Kota(Id_kota) NOT NULL,
		Id_subkategori VARCHAR(20) CONSTRAINT FK_Produk_Id_subkategori REFERENCES SubkategoriProduk(Id_subkategori) NOT NULL,
		Nama_produk NVARCHAR(200),
		Harga VARCHAR(15),
		Diskon VARCHAR(5),
		Rating FLOAT,
		Terjual VARCHAR(100)
	);

	CREATE TABLE MasterProduk(
		Id_ecommerce VARCHAR(10) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
		Id_subkategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_subkategori REFERENCES SubKategoriProduk(Id_subkategori),
		Id_toko VARCHAR(100) CONSTRAINT FK_MasterProduk_Id_toko REFERENCES Toko(Id_toko),
		Id_produk VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
		Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
		Id_provinsi VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_provinsi REFERENCES Provinsi(Id_provinsi)
	);

	-- 24 May 2024
--> SubkategoriProduk -> KategoriProduk -> Kota (Longitude, Latitude) -> Provinsi -> E_commerce -> Toko -> Produk -> MasterProduk
	USE Ecommerce

	CREATE TABLE E_commerce (
		Id_ecommerce VARCHAR(10) PRIMARY KEY NOT NULL,
		Nama_ecommerce VARCHAR(25) NOT NULL
	);

	CREATE TABLE Provinsi(
		Id_provinsi VARCHAR(20) PRIMARY KEY NOT NULL,
		Nama_provinsi VARCHAR(30) NOT NULL
	);

	CREATE TABLE Kota (
		Id_kota VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_provinsi VARCHAR(20) CONSTRAINT Fk_Kota_Id_provinsi REFERENCES Provinsi(Id_provinsi),
		Nama_kota VARCHAR(50) NOT NULL,
		latitude FLOAT,
		longitude FLOAT
	);

	CREATE TABLE KategoriProduk (
		Id_kategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Kategori_barang VARCHAR(30) NOT NULL
	);

	CREATE TABLE SubKategoriProduk(
		Id_subkategori VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_kategori VARCHAR(20) CONSTRAINT FK_SubKategoriProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori), 
		Subkategori_barang VARCHAR(50) NOT NULL
	);

	CREATE TABLE Toko (
		Id_toko VARCHAR(100) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Toko_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Nama_toko VARCHAR (100),
		Jam_operasi VARCHAR (25),
		Rating_toko FLOAT,
		Pesanan_proses VARCHAR(25),
		Tanggal_berdiri NVARCHAR(50)
	);
	
	CREATE TABLE Produk (
		Id_produk VARCHAR(20) PRIMARY KEY NOT NULL,
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_Produk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce) NOT NULL,
		Id_toko VARCHAR(100) CONSTRAINT FK_Produk_Id_toko REFERENCES Toko(Id_toko) NOT NULL,
		Id_kota VARCHAR(20) CONSTRAINT FK_Produk_Id_kota REFERENCES Kota(Id_kota) NOT NULL,
		Id_subkategori VARCHAR(20) CONSTRAINT FK_Produk_Id_subkategori REFERENCES SubkategoriProduk(Id_subkategori) NOT NULL,
		Nama_produk NVARCHAR(200),
		Harga VARCHAR(15),
		Diskon NVARCHAR(30),
		Rating FLOAT,
		Terjual VARCHAR(100)
	);

	CREATE TABLE MasterProduk(
		Id_produk VARCHAR(20) PRIMARY KEY CONSTRAINT FK_MasterProduk_Id_produk REFERENCES Produk(Id_produk),
		Id_kategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kategori REFERENCES KategoriProduk(Id_kategori),
		Id_subkategori VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_subkategori REFERENCES SubKategoriProduk(Id_subkategori),
		Id_toko VARCHAR(100) CONSTRAINT FK_MasterProduk_Id_toko REFERENCES Toko(Id_toko),
		Id_kota VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_kota REFERENCES Kota(Id_kota),
		Id_ecommerce VARCHAR(10) CONSTRAINT FK_MasterProduk_Id_e_commerce REFERENCES E_commerce(Id_ecommerce),
		Id_provinsi VARCHAR(20) CONSTRAINT FK_MasterProduk_Id_provinsi REFERENCES Provinsi(Id_provinsi)
	);

	INSERT INTO MasterProduk (
	Id_produk,
    Id_kategori,
    Id_subkategori,
    Id_toko,
	Id_ecommerce,
    Id_kota,
	Id_provinsi
	)
		SELECT
		e.Id_ecommerce,
		t.Id_toko,
		p.Id_produk,
		kt.Id_kota,
		pv.Id_provinsi,
		k.Id_kategori,
		s.Id_subkategori
		FROM Produk p
		LEFT JOIN SubKategoriProduk s ON p.Id_subkategori = s.Id_subkategori
		LEFT JOIN KategoriProduk k ON s.Id_kategori = k.Id_kategori
		LEFT JOIN Toko t ON p.Id_toko = t.Id_toko
		LEFT JOIN Kota kt ON p.Id_kota = kt.Id_kota
		LEFT JOIN Provinsi pv ON kt.Id_provinsi = pv.Id_provinsi
		LEFT JOIN E_commerce e ON p.Id_ecommerce = e.Id_ecommerce