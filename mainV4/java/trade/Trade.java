package trade;

public class Trade {
	private int tradeID;
	private String tradeTitle;
	private String userID;
	private String tradeDate;
	private String tradeContent;
	private int tradeAvailable;
	
	public int getTradeID() {
		return tradeID;
	}
	public void setTradeID(int tradeID) {
		this.tradeID = tradeID;
	}
	public String getTradeTitle() {
		return tradeTitle;
	}
	public void setTradeTitle(String tradeTitle) {
		this.tradeTitle = tradeTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTradeDate() {
		return tradeDate;
	}
	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}
	public String getTradeContent() {
		return tradeContent;
	}
	public void setTradeContent(String tradeContent) {
		this.tradeContent = tradeContent;
	}
	public int getTradeAvailable() {
		return tradeAvailable;
	}
	public void setTradeAvailable(int tradeAvailable) {
		this.tradeAvailable = tradeAvailable;
	}
}
