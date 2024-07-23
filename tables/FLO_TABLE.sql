USE [FLO_CUSTOMERS]
GO

/****** Object:  Table [dbo].[FLO]    Script Date: 23.07.2024 03:19:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FLO](
	[master_id] [varchar](50) NULL,
	[order_channel] [varchar](50) NULL,
	[last_order_channel] [varchar](50) NULL,
	[first_order_date] [datetime] NULL,
	[last_order_date] [datetime] NULL,
	[last_order_date_online] [datetime] NULL,
	[last_order_date_offline] [datetime] NULL,
	[order_num_total_ever_online] [smallint] NULL,
	[order_num_total_ever_offline] [smallint] NULL,
	[customer_value_total_ever_offline] [int] NULL,
	[customer_value_total_ever_online] [int] NULL,
	[interested_in_categories_12] [varchar](50) NULL,
	[store_type] [varchar](50) NULL
) ON [PRIMARY]
GO

