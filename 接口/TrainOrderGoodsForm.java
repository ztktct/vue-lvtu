package train.trainSide.ordermanage.model;

import com.h8h.framework.BaseObject;

public class TrainOrderGoodsForm  extends BaseObject{

	
	private static final long serialVersionUID = 1L;
	private long ogId;//  
	private long ogOrderId;//订单id  
	private String ogOrderNo;//订单编号  
	private String ogComGoodsId;//商品库商品id  
	private String ogComGoodsName;//  
	private String ogComGoodsImg;//  
	private String ogComGoodsClassId;//类别id  
	private String ogComGoodsPriceDiscount;//订单商品价格  
	private String ogShopGoodsId;//门店商品id  
	private String ogShopGoodsNum;//商品数量  
	private String ogShopGoodsTotal;//商品总金额  
	private String ogActivitySelId;//商品活动id(0-无活动)  
	private String ogActivitySelType;//活动所属类型(门店,平台)  
	private String ogActivitySelPrice;//活动价格(单价,单位:分)  
	private String ogActivityRecharge;//充值金额(+送)  

	public void setOgId(long ogId){
		this.ogId=ogId;
	}

	public long getOgId(){
		return ogId;
	}

	public void setOgOrderId(long ogOrderId){
		this.ogOrderId=ogOrderId;
	}

	public long getOgOrderId(){
		return ogOrderId;
	}

	public void setOgOrderNo(String ogOrderNo){
		this.ogOrderNo=ogOrderNo;
	}

	public String getOgOrderNo(){
		return ogOrderNo;
	}

	public void setOgComGoodsId(String ogComGoodsId){
		this.ogComGoodsId=ogComGoodsId;
	}

	public String getOgComGoodsId(){
		return ogComGoodsId;
	}

	public void setOgComGoodsName(String ogComGoodsName){
		this.ogComGoodsName=ogComGoodsName;
	}

	public String getOgComGoodsName(){
		return ogComGoodsName;
	}

	public void setOgComGoodsImg(String ogComGoodsImg){
		this.ogComGoodsImg=ogComGoodsImg;
	}

	public String getOgComGoodsImg(){
		return ogComGoodsImg;
	}

	public void setOgComGoodsClassId(String ogComGoodsClassId){
		this.ogComGoodsClassId=ogComGoodsClassId;
	}

	public String getOgComGoodsClassId(){
		return ogComGoodsClassId;
	}

	public void setOgComGoodsPriceDiscount(String ogComGoodsPriceDiscount){
		this.ogComGoodsPriceDiscount=ogComGoodsPriceDiscount;
	}

	public String getOgComGoodsPriceDiscount(){
		return ogComGoodsPriceDiscount;
	}

	public void setOgShopGoodsId(String ogShopGoodsId){
		this.ogShopGoodsId=ogShopGoodsId;
	}

	public String getOgShopGoodsId(){
		return ogShopGoodsId;
	}

	public void setOgShopGoodsNum(String ogShopGoodsNum){
		this.ogShopGoodsNum=ogShopGoodsNum;
	}

	public String getOgShopGoodsNum(){
		return ogShopGoodsNum;
	}

	public void setOgShopGoodsTotal(String ogShopGoodsTotal){
		this.ogShopGoodsTotal=ogShopGoodsTotal;
	}

	public String getOgShopGoodsTotal(){
		return ogShopGoodsTotal;
	}

	public void setOgActivitySelId(String ogActivitySelId){
		this.ogActivitySelId=ogActivitySelId;
	}

	public String getOgActivitySelId(){
		return ogActivitySelId;
	}

	public void setOgActivitySelType(String ogActivitySelType){
		this.ogActivitySelType=ogActivitySelType;
	}

	public String getOgActivitySelType(){
		return ogActivitySelType;
	}

	public void setOgActivitySelPrice(String ogActivitySelPrice){
		this.ogActivitySelPrice=ogActivitySelPrice;
	}

	public String getOgActivitySelPrice(){
		return ogActivitySelPrice;
	}

	public void setOgActivityRecharge(String ogActivityRecharge){
		this.ogActivityRecharge=ogActivityRecharge;
	}

	public String getOgActivityRecharge(){
		return ogActivityRecharge;
	}
	

}
