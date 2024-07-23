-- QUESTION 2 Kaç farklý müþterinin alýþveriþ yaptýðýný gösterecek sorguyu yazýnýz
SELECT COUNT(master_id)
FROM FLO;

----------------------------------------------------------------------------------
-- QUESTION 3 Toplam yapýlan alýþveriþ sayýsý ve ciroyu getirecek sorguyu yazýnýz
SELECT 
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM 
    FLO;


-- QUESTION 4 Alýþveriþ baþýna ortalama ciroyu getirecek sorguyu yazýnýz
SELECT
	AVG((customer_value_total_ever_online + customer_value_total_ever_offline) / (order_num_total_ever_online + order_num_total_ever_offline))
FROM
	FLO;

----------------------------------------------------------------------------------
-- QUESTION 5 En son alýþveriþ yapýlan kanal (last_order_channel) üzerinden yapýlan alýþveriþlerin toplam ciro ve alýþveriþ sayýlarýný
-- getirecek sorguyu yazýnýz.
SELECT 
	last_order_channel,
	SUM(order_num_total_ever_online + order_num_total_ever_offline) AS TOPLAM_SIPARIS,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM 
	FLO
GROUP BY
	last_order_channel;

----------------------------------------------------------------------------------
-- QUESTION 6 Store type kýrýlýmýnda elde edilen toplam ciroyu getiren sorguyu yazýnýz
SELECT
	store_type,
	SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS TOPLAM_CIRO
FROM
	FLO
GROUP BY
	store_type;

----------------------------------------------------------------------------------
-- QUESTION 7 Yýl kýrýlýmýnda alýþveriþ sayýlarýný getirecek sorguyu yazýnýz 
--(Yýl olarak müþterinin ilk alýþveriþ tarihi (first_order_date) yýlýný baz alýnýz)
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
-- QUESTION 8 En son alýþveriþ yapýlan kanal kýrýlýmýnda alýþveriþ baþýna ortalama ciroyu hesaplayacak sorguyu yazýnýz
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
-- QUESTION 9 Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazýnýz.
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
-- QUESTION 10 En çok tercih edilen store_type
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
-- QUESTION 11 last_order_channel bazýnda, en çok ilgi gören kategori ve bundan ne kadarlýk alýþveriþ yapýldý
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
-- QUESTION 12 En çok alýþveriþ yapan kiþinin ID'si
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
-- QUESTION 13 En çok alýþveriþ yapan kiþinin, alýþveriþ baþýna ortalama cirosunu ve 
-- alýþveriþ yapma gün ortalamasý (alýþveriþ sýklýðý)

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
-- QUESTION 14 En çok alýþveriþ yapan (ciro bazýnda) ilk 100 kiþinin 
-- alýþveriþ yapma gün ortalamasýný (alýþveriþ sýklýðý)
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
-- QUESTION 15 En son alýþveriþ yapýlan kanal (last_order_channel) kýrýlýmýnda 
--en çok alýþveriþ yapan müþteri
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
-- QUESTION 15 En son alýþveriþ yapan kiþinin ID’ sini getiren sorguyu yazýnýz. 
-- (Max son tarihte birden fazla alýþveriþ yapan ID bulunmakta.Bunlarý da getiriniz
SELECT 
    master_id,
	last_order_date

FROM 
    FLO
WHERE 
    last_order_date = (SELECT MAX(last_order_date) FROM FLO)

ORDER BY
	last_order_date DESC;