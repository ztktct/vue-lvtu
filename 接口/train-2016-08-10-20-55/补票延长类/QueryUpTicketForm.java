package train.trainSide.upticket.model;

import java.util.Date;

import train.trainSide.base.model.BupModel;

/****
**/
public class QueryUpTicketForm extends BupModel {

	/**
	 * 店铺产品
	 */
	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private long ticketId;
	private String ticketName;//
	private String ticketPhone;
	
	private String ticketTrain;
	private String ticketCarriage;//车厢
	private String ticketSeat;
	private String ticketStart;
	private String ticketEnd;
	private String ticketMemberId;//会员
	private String ticketShopId;
	private String ticketIs;
	private String ticketCreateDate;
	private String ticketCreateDateStamp;
	private String partnerId;
	private int pageIndex ;
	private int pageSize;

	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getPartnerId() {
		return partnerId;
	}
	public void setPartnerId(String partnerId) {
		this.partnerId = partnerId;
	}
	public long getTicketId() {
		return ticketId;
	}
	public String getTicketName() {
		return ticketName;
	}
	public String getTicketPhone() {
		return ticketPhone;
	}
	public String getTicketTrain() {
		return ticketTrain;
	}
	public String getTicketCarriage() {
		return ticketCarriage;
	}
	public String getTicketSeat() {
		return ticketSeat;
	}
	public String getTicketStart() {
		return ticketStart;
	}
	public String getTicketEnd() {
		return ticketEnd;
	}
	public String getTicketMemberId() {
		return ticketMemberId;
	}
	public String getTicketShopId() {
		return ticketShopId;
	}
	public String getTicketIs() {
		return ticketIs;
	}
	public String getTicketCreateDate() {
		return ticketCreateDate;
	}
	public String getTicketCreateDateStamp() {
		return ticketCreateDateStamp;
	}
	public void setTicketId(long ticketId) {
		this.ticketId = ticketId;
	}
	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}
	public void setTicketPhone(String ticketPhone) {
		this.ticketPhone = ticketPhone;
	}
	public void setTicketTrain(String ticketTrain) {
		this.ticketTrain = ticketTrain;
	}
	public void setTicketCarriage(String ticketCarriage) {
		this.ticketCarriage = ticketCarriage;
	}
	public void setTicketSeat(String ticketSeat) {
		this.ticketSeat = ticketSeat;
	}
	public void setTicketStart(String ticketStart) {
		this.ticketStart = ticketStart;
	}
	public void setTicketEnd(String ticketEnd) {
		this.ticketEnd = ticketEnd;
	}
	public void setTicketMemberId(String ticketMemberId) {
		this.ticketMemberId = ticketMemberId;
	}
	public void setTicketShopId(String ticketShopId) {
		this.ticketShopId = ticketShopId;
	}
	public void setTicketIs(String ticketIs) {
		this.ticketIs = ticketIs;
	}
	public void setTicketCreateDate(String ticketCreateDate) {
		this.ticketCreateDate = ticketCreateDate;
	}
	public void setTicketCreateDateStamp(String ticketCreateDateStamp) {
		this.ticketCreateDateStamp = ticketCreateDateStamp;
	}
	

}
