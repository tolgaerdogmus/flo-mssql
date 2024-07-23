-- QUESTION 2 Ka� farkl� m��terinin al��veri� yapt���n� g�sterecek sorguyu yaz�n�z
SELECT COUNT(master_id)
FROM FLO;

----------------------------------------------------------------------------------
-- QUESTION 3 Toplam yap�lan al��veri� say�s� ve ciroyu getirecek sorguyu yaz�n�z
SELECT 
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM 
    FLO;


-- QUESTION 4 Al��veri� ba��na ortalama ciroyu getirecek sorguyu yaz�n�z
SELECT
	AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / (order_num_total_ever_online + order_num_total_ever_offline))
FROM
	FLO;

----------------------------------------------------------------------------------
-- QUESTION 5 En son al��veri� yap�lan kanal (last_order_channel) �zerinden yap�lan al��veri�lerin toplam ciro ve al��veri� say�lar�n�
-- getirecek sorguyu yaz�n�z.
SELECT 
	last_order_channel,
	SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM 
	FLO
GROUP BY
	last_order_channel;

----------------------------------------------------------------------------------
-- QUESTION 6 Store type k�r�l�m�nda elde edilen toplam ciroyu getiren sorguyu yaz�n�z
SELECT
	store_type,
	SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM
	FLO
GROUP BY
	store_type;

----------------------------------------------------------------------------------
-- QUESTION 7 Y�l k�r�l�m�nda al��veri� say�lar�n� getirecek sorguyu yaz�n�z 
--(Y�l olarak m��terinin ilk al��veri� tarihi (first_order_date) y�l�n� baz al�n�z)
SELECT
	DATEPART(YEAR,first_order_date),
	SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS
FROM
	FLO
GROUP BY
	DATEPART(YEAR,first_order_date)
ORDER BY
	DATEPART(YEAR,first_order_date) DESC;

----------------------------------------------------------------------------------
-- QUESTION 8 En son al��veri� yap�lan kanal k�r�l�m�nda al��veri� ba��na ortalama ciroyu hesaplayacak sorguyu yaz�n�z
SELECT
	last_order_channel,
	AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / (order_num_total_ever_online + order_num_total_ever_offline)) ORTALAMA_CIRO
FROM
	FLO
GROUP BY
	last_order_channel
ORDER BY
	ORTALAMA_CIRO DESC;

----------------------------------------------------------------------------------
-- QUESTION 9 Son 12 ayda en �ok ilgi g�ren kategoriyi getiren sorguyu yaz�n�z.
SELECT TOP 1
    interested_in_categories_12,
    COUNT(*) AS count
FROM
    FLO
GROUP BY
    interested_in_categories_12
ORDER BY
    count DESC;

----------------------------------------------------------------------------------
-- QUESTION 10 En �ok tercih edilen store_type
SELECT TOP 1
    store_type,
    COUNT(*) AS count
FROM
    FLO
GROUP BY
    store_type
ORDER BY
    count DESC;

----------------------------------------------------------------------------------
-- QUESTION 11 last_order_channel baz�nda, en �ok ilgi g�ren kategori ve bundan ne kadarl�k al��veri� yap�ld�
SELECT TOP 1
    last_order_channel,
	SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO,
    COUNT(*) AS count
FROM
    FLO
GROUP BY
    last_order_channel
ORDER BY
    count DESC;

----------------------------------------------------------------------------------
-- QUESTION 12 En �ok al��veri� yapan ki�inin ID'si
SELECT TOP 1
	SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
	master_id
FROM
	FLO
GROUP BY
	master_id
ORDER BY
	TOPLAM_SIPARIS DESC;

----------------------------------------------------------------------------------
-- QUESTION 13 En �ok al��veri� yapan ki�inin, al��veri� ba��na ortalama cirosunu ve 
-- al��veri� yapma g�n ortalamas� (al��veri� s�kl���)

SELECT TOP 1
	master_id,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_CIRO,
	AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / (order_num_total_ever_online + order_num_total_ever_offline)) ORTALAMA_CIRO,
	DATEDIFF(day, MIN(first_order_date), MAX(last_order_date)) / SUM(order_num_total_ever_online + order_num_total_ever_offline)
        GUN_BAZINDA_ALISVERIS_SIKLIGI
FROM 
    FLO
GROUP BY
	master_id
ORDER BY
	TOPLAM_SIPARIS DESC;

----------------------------------------------------------------------------------
-- QUESTION 14 En �ok al��veri� yapan (ciro baz�nda) ilk 100 ki�inin 
-- al��veri� yapma g�n ortalamas�n� (al��veri� s�kl���)
SELECT TOP 100
	master_id,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_CIRO,
	AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / (order_num_total_ever_online + order_num_total_ever_offline)) ORTALAMA_CIRO,
	DATEDIFF(day, MIN(first_order_date), MAX(last_order_date)) / SUM(order_num_total_ever_online + order_num_total_ever_offline)
        GUN_BAZINDA_ALISVERIS_SIKLIGI
FROM 
    FLO
GROUP BY
	master_id
ORDER BY
	TOPLAM_CIRO DESC;

----------------------------------------------------------------------------------
-- QUESTION 15 En son al��veri� yap�lan kanal (last_order_channel) k�r�l�m�nda 
--en �ok al��veri� yapan m��teri
SELECT TOP 1
    master_id,
    last_order_channel,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO,
    AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / 
        (order_num_total_ever_online + order_num_total_ever_offline)) AS ORTALAMA_CIRO,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) / 
        DATEDIFF(day, MIN(first_order_date), MAX(last_order_date)) AS GUN_BAZINDA_ALISVERIS_SIKLIGI
FROM 
    FLO
GROUP BY
    last_order_channel, master_id
ORDER BY
    TOPLAM_SIPARIS DESC;


----------------------------------------------------------------------------------
-- QUESTION 15 En son al��veri� yapan ki�inin ID� sini getiren sorguyu yaz�n�z. 
-- (Max son tarihte birden fazla al��veri� yapan ID bulunmakta.Bunlar� da getiriniz
SELECT 
    master_id,
	last_order_date

FROM 
    FLO
WHERE 
    last_order_date = (SELECT MAX(last_order_date) FROM FLO)

ORDER BY
	last_order_date DESC;