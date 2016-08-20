package train.trainSide.product.model;

import java.util.Date;

import train.trainSide.base.model.BupModel;

/****
**/
public class PartnerShopGoodsForm extends BupModel {

	/**
	 * 店铺产品
	 */
	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	private int shop_goods_id;// 门店商品id
	private String shop_com_goods_id;// 商品库商品id
	private String shop_goods_name;// 商品名称
	private String shop_goods_desc;//
	private String shop_goods_img;//
	private String shop_goods_price;//
	private String shop_goods_price_discount;// 折扣价
	private String shop_goods_class_id;//
	private String shop_goods_class_name;//
	private String isSell;// 出售状态
	private String shop_goods_store;//库存
	private String shop_goods_is_shelve;//是否上架
	private String shop_goods_sort;//
	private String shop_goods_is_comd;// 是否推荐
	private Date create_on;// 添加时间
	private String queryProductDateBeg;// 添加时间开始
	private String queryProductDateEnd;// 添加时间结束
	private String shop_goods_buy_cnt;//
	private Date shop_goods_sel_date;//
	private String shop_partner_shop_id;// 门店id
	private String partnerId;// 商家id
	private String shopName;//
	private String scanCount;//
	private String productCategory;//产品分类
	private String priceFromLowToUp;
	private String priceFromUpToLow;
	private String selNumFormUp;
	private String goodsStr;
	private  String id;
	private String stocks;
	private String sorts;
	private String tableName;//数据库表名
	private int countShelveQuery;//上架总数量
	private int countClassQuery;//某类别总数量
	
	
	public String getGoodsStr() {
		return goodsStr;
	}
	public void setGoodsStr(String goodsStr) {
		this.goodsStr = goodsStr;
	}
	public String getPriceFromLowToUp() {
		return priceFromLowToUp;
	}
	public String getPriceFromUpToLow() {
		return priceFromUpToLow;
	}
	public String getSelNumFormUp() {
		return selNumFormUp;
	}
	public void setPriceFromLowToUp(String priceFromLowToUp) {
		this.priceFromLowToUp = priceFromLowToUp;
	}
	public void setPriceFromUpToLow(String priceFromUpToLow) {
		this.priceFromUpToLow = priceFromUpToLow;
	}
	public void setSelNumFormUp(String selNumFormUp) {
		this.selNumFormUp = selNumFormUp;
	}

	private int shop_goods_delete_is;
	
	public int getShop_goods_delete_is() {
		return shop_goods_delete_is;
	}
	public void setShop_goods_delete_is(int shop_goods_delete_is) {
		this.shop_goods_delete_is = shop_goods_delete_is;
	}
	public int getShop_goods_id() {
		return shop_goods_id;
	}
	public String getShop_com_goods_id() {
		return shop_com_goods_id;
	}
	public String getShop_goods_name() {
		return shop_goods_name;
	}
	public String getShop_goods_desc() {
		return shop_goods_desc;
	}
	public String getShop_goods_img() {
		return shop_goods_img;
	}
	public String getShop_goods_price() {
		return shop_goods_price;
	}
	public String getShop_goods_price_discount() {
		return shop_goods_price_discount;
	}
	public String getShop_goods_class_id() {
		return shop_goods_class_id;
	}
	public String getShop_goods_class_name() {
		return shop_goods_class_name;
	}
	public String getIsSell() {
		return isSell;
	}
	public String getShop_goods_store() {
		return shop_goods_store;
	}
	public String getShop_goods_is_shelve() {
		return shop_goods_is_shelve;
	}
	public String getShop_goods_sort() {
		return shop_goods_sort;
	}
	public String getShop_goods_is_comd() {
		return shop_goods_is_comd;
	}
	public Date getCreate_on() {
		return create_on;
	}
	public String getQueryProductDateBeg() {
		return queryProductDateBeg;
	}
	public String getQueryProductDateEnd() {
		return queryProductDateEnd;
	}
	public String getShop_goods_buy_cnt() {
		return shop_goods_buy_cnt;
	}
	public Date getShop_goods_sel_date() {
		return shop_goods_sel_date;
	}
	public String getShop_partner_shop_id() {
		return shop_partner_shop_id;
	}
	public String getPartnerId() {
		return partnerId;
	}
	public String getShopName() {
		return shopName;
	}
	public String getScanCount() {
		return scanCount;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setShop_goods_id(int shop_goods_id) {
		this.shop_goods_id = shop_goods_id;
	}
	public void setShop_com_goods_id(String shop_com_goods_id) {
		this.shop_com_goods_id = shop_com_goods_id;
	}
	public void setShop_goods_name(String shop_goods_name) {
		this.shop_goods_name = shop_goods_name;
	}
	public void setShop_goods_desc(String shop_goods_desc) {
		this.shop_goods_desc = shop_goods_desc;
	}
	public void setShop_goods_img(String shop_goods_img) {
		this.shop_goods_img = shop_goods_img;
	}
	public void setShop_goods_price(String shop_goods_price) {
		this.shop_goods_price = shop_goods_price;
	}
	public void setShop_goods_price_discount(String shop_goods_price_discount) {
		this.shop_goods_price_discount = shop_goods_price_discount;
	}
	public void setShop_goods_class_id(String shop_goods_class_id) {
		this.shop_goods_class_id = shop_goods_class_id;
	}
	public void setShop_goods_class_name(String shop_goods_class_name) {
		this.shop_goods_class_name = shop_goods_class_name;
	}
	public void setIsSell(String isSell) {
		this.isSell = isSell;
	}
	public void setShop_goods_store(String shop_goods_store) {
		this.shop_goods_store = shop_goods_store;
	}
	public void setShop_goods_is_shelve(String shop_goods_is_shelve) {
		this.shop_goods_is_shelve = shop_goods_is_shelve;
	}
	public void setShop_goods_sort(String shop_goods_sort) {
		this.shop_goods_sort = shop_goods_sort;
	}
	public void setShop_goods_is_comd(String shop_goods_is_comd) {
		this.shop_goods_is_comd = shop_goods_is_comd;
	}
	public void setCreate_on(Date create_on) {
		this.create_on = create_on;
	}
	public void setQueryProductDateBeg(String queryProductDateBeg) {
		this.queryProductDateBeg = queryProductDateBeg;
	}
	public void setQueryProductDateEnd(String queryProductDateEnd) {
		this.queryProductDateEnd = queryProductDateEnd;
	}
	public void setShop_goods_buy_cnt(String shop_goods_buy_cnt) {
		this.shop_goods_buy_cnt = shop_goods_buy_cnt;
	}
	public void setShop_goods_sel_date(Date shop_goods_sel_date) {
		this.shop_goods_sel_date = shop_goods_sel_date;
	}
	public void setShop_partner_shop_id(String shop_partner_shop_id) {
		this.shop_partner_shop_id = shop_partner_shop_id;
	}
	public void setPartnerId(String partnerId) {
		this.partnerId = partnerId;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public void setScanCount(String scanCount) {
		this.scanCount = scanCount;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStocks() {
		return stocks;
	}
	public void setStocks(String stocks) {
		this.stocks = stocks;
	}
	public String getSorts() {
		return sorts;
	}
	public void setSorts(String sorts) {
		this.sorts = sorts;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public int getCountShelveQuery() {
		return countShelveQuery;
	}
	public void setCountShelveQuery(int countShelveQuery) {
		this.countShelveQuery = countShelveQuery;
	}
	public int getCountClassQuery() {
		return countClassQuery;
	}
	public void setCountClassQuery(int countClassQuery) {
		this.countClassQuery = countClassQuery;
	}
	

}
