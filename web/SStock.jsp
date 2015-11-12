
<%@page  import ="java.sql.*"%>
<%!
    public static Connection connect() {

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            return DriverManager.getConnection("jdbc:mysql://localhost/stocdatabase", "root", "123456");
        } catch (Exception e) {
            return null;
        }

    }

    public static boolean close(Connection c) {
        try {
            c.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }


%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock</title>
    </head>
    <body>
        <h1 align="center"><a href='Stkinfo.jsp'>Stock Information </a>&nbsp;&nbsp;&nbsp;&nbsp;  <a href='Stkq.jsp'>Stock Limited Quantity </a></h1>

        <h1>Stock List</h1>
        <% int counterpid = 0;String stocname="";
            int cout = 0;
            int cout2 = 0;
            int cout3 = 0;
            int cout4 = 0;
            int sourstock = 0;
            int catfk = 0;
            String pname = "";
            int prixx = 0;
            try {

                Connection c = connect();
                Statement stmt = c.createStatement();

                int sss = Integer.parseInt(session.getAttribute("theName").toString());
                ResultSet rs = stmt.executeQuery("select s.stockid,s.Stockname,p.idproduct,p.productname,p.productQuantity,p.productmodel from stocdatabase.stock s,stocdatabase.stocpro sp,stocdatabase.product p where s.Stockid=sp.stocid and p.idproduct=sp.prodid1 and s.Stockid<>" + sss + "");

        %>



        <% while (rs.next()) {%> 


        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100"><col width="100">

            <tbody>
                <tr>
                    <td><%out.println(rs.getString(1));%></td> 
                    <td><%out.println(rs.getString(2));%></td> 
                    <td><%out.println(rs.getString(3));%></td> 
                    <td><%out.println(rs.getString(4));%></td> 
                    <td><%out.println(rs.getString(5));%></td>
                    <td><%out.println(rs.getString(6));%></td> 
                </tr>

            </tbody>
        </table>  
        <%  }

                c.close();
            } catch (Exception e) {

            }
        %>
        <h1>Getting Product From Other Stocks</h1>    
        <form name="name1" action="#" method="POST">
            <table border="1">


                <tr>
                    <td>Current Stock Name:</td>
                    <td><input type="text" name="stocksource" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Order Date :</td>
                    <td><input type="text" name="odate" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Destination Stock Name:</td>
                    <td><input type="text" name="stockdestination" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Car number :</td>
                    <td><input type="text" name="cnumber" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>driver id:</td>
                    <td><input type="text" name="did" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>product id:</td>
                    <td><input type="text" name="pid" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>product model:</td>
                    <td><input type="text" name="pmodel" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>product Quantity :</td>
                    <td><input type="text" name="pquantity" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>

        <% if (request.getMethod().equals("POST")) {
                String stocksource, odate, stockdestination, cnumber, did, pid, pquantity, pmodel;
                stocksource = request.getParameter("stocksource");
                odate = request.getParameter("odate");
                stockdestination = request.getParameter("stockdestination");
                cnumber = request.getParameter("cnumber");
                did = request.getParameter("did");
                pid = request.getParameter("pid");
                pmodel = request.getParameter("pmodel");
                pquantity = request.getParameter("pquantity");

                try {
                    Connection c = connect();

                    String sql = "insert into stocdatabase.transfer(sourcestock,sourcedate,destinationstock,driverid,carnumber,productid,productQuantity)  values ('" + stocksource + "','" + odate + "','" + stockdestination + "'," + did + ",'" + cnumber + "'," + pid + "," + pquantity + ")";

                    Statement stmt1 = c.createStatement();
                    stmt1.executeUpdate(sql);

                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            }%>
        <h1>Transfer Need Validation</h1>

        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                int sss = Integer.parseInt(session.getAttribute("theName").toString());
                ResultSet rs1 = stmt.executeQuery("select Stockname from stocdatabase.stock where Stockid=" + sss + "");
                while (rs1.next()) {
                    stocname = rs1.getString(1);
                    request.setAttribute("stocname1", stocname);
                   

                }
                
                ResultSet rs = stmt.executeQuery("select * from transfer where destinationstock<>'" + request.getAttribute("stocname1").toString()+ "' and validatedestinationstock is not null");
        %>

        <% while (rs.next()) {%>
        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100">
            <tr>
                <td><%out.println(rs.getString(1));%></td> 
                <td><%out.println(rs.getString(2));%></td> 
                <td><%out.println(rs.getString(3));%></td> 
                <td><%out.println(rs.getString(4));%></td> 
                <td><%out.println(rs.getString(5));%></td>
                <td><%out.println(rs.getString(6));%></td> 
                <td><%out.println(rs.getString(7));%></td> 
                <td><%out.println(rs.getString(8));%></td> 
                <td><%out.println(rs.getString(9));%></td> 
                <td><%out.println(rs.getString(10));%></td>  
            </tr>
        </table>  
        <%  }
                c.close();
            } catch (Exception e) {

            }


        %>
        <h1>Validate Product Ordered by Beirut Stock</h1>    
        <form name="name1" action="#" method="POST">
            <table border="1">


                <tr>
                    <td>Transfer ID :</td>
                    <td><input type="text" name="TID" value="" size="50" autocomplete="off"/></td>
                </tr>


                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>

        <% int pid2, pq2, realpq;
            String model1;

            if (request.getMethod().equals("POST")) {
                String TID;
                TID = request.getParameter("TID");

                try {

                    Connection c = connect();
                    Statement stmt = c.createStatement();
                    ResultSet rs = stmt.executeQuery("select transferid,sourcestock,sourcedate,destinationstock,driverid,carnumber,productid,productQuantity,productmodel from transfer where transferid=" + TID + "");

                    while (rs.next()) {
                        pid2 = Integer.parseInt(rs.getString(7));
                        request.setAttribute("prodid2", pid2);
                        pq2 = Integer.parseInt(rs.getString(8));
                        sourstock = Integer.parseInt(rs.getString(2));

                        request.setAttribute("Sourcestock", sourstock);
                        request.setAttribute("prodq2", pq2);
                        model1 = rs.getString(9);
                        request.setAttribute("prodmodel", model1);

                    }
                    int pid = Integer.parseInt(request.getAttribute("prodid2").toString());
                    Statement stmt1 = c.createStatement();
                    ResultSet rs1 = stmt1.executeQuery("Select productQuantity from stocdatabase.product where idproduct=" + pid + "");
                    while (rs1.next()) {

                        realpq = Integer.parseInt(rs1.getString(1));
                        request.setAttribute("realpq1", realpq);

                    }

                    int s = Integer.parseInt(request.getAttribute("realpq1").toString()) - Integer.parseInt(request.getAttribute("prodq2").toString());
                    request.setAttribute("qs", s);
                    if (s < 0) {

                        out.println("we dont have enough quantity");
                        String sql2 = "update  stocdatabase.transfer  set validatedestinationstock=" + "we dont have enough quantity" + " where transferid=" + TID + "";

                        Statement stmt2 = c.createStatement();
                        stmt2.executeUpdate(sql2);

                    } else if (s < 4 && s > 0) {
                        int r = Integer.parseInt(request.getAttribute("qs").toString());
                        out.println("Alert you reached Product Limit");

                        String sql = "update  stocdatabase.product  set productQuantity=" + r + " where idproduct=" + Integer.parseInt(request.getAttribute("prodid2").toString()) + "";

                        Statement stmt2 = c.createStatement();
                        stmt2.executeUpdate(sql);

                        Statement stmt5 = c.createStatement();

                        ResultSet rs5 = stmt5.executeQuery("Select count(idproduct) ,productQuantity,idproduct from stocdatabase.stock s,stocdatabase.stocpro sp,stocdatabase.product p where s.Stockid=sp.stocid and p.idproduct=sp.prodid1 and s.Stockid= " + Integer.parseInt(request.getAttribute("Sourcestock").toString()) + " and  productmodel='" + request.getAttribute("prodmodel").toString() + "'");
                        while (rs.next()) {
                            cout2 = Integer.parseInt(rs.getString(1));
                            cout3 = Integer.parseInt(rs.getString(2));
                            cout4 = Integer.parseInt(rs.getString(3));
                            request.setAttribute("pmodelexist", cout2);
                            request.setAttribute("pmodelquantity", cout3);
                            request.setAttribute("pid", cout4);
                        }
                        String modeld = request.getAttribute("pmodelexist").toString();
                        String modeld1 = request.getAttribute("pmodelquantity").toString();
                        String modeld2 = request.getAttribute("pid").toString();
                        int modelq = Integer.parseInt(modeld);
                        int modelq2 = Integer.parseInt(modeld2);
                        int modelq1 = Integer.parseInt(modeld1) + Integer.parseInt(request.getAttribute("prodq2").toString());
                        if (modelq > 0) {
                            out.println(" Model Exist " + modelq1 + "  " + modelq2 + " ");

                            String sqlm = "update  stocdatabase.product  set productQuantity=" + modelq1 + " where idproduct=" + modelq2 + "";

                            Statement stmt15 = c.createStatement();
                            stmt15.executeUpdate(sqlm);

                        } else if (modelq == 0) {

                            Statement stmt25 = c.createStatement();
                            ResultSet rs25 = stmt25.executeQuery("Select idproduct,productname,productmodel,productQuantity,prix,Rdate,catfk from product where idproduct=" + modelq2 + "");
                            while (rs.next()) {
                                catfk = Integer.parseInt(rs.getString(1));
                                pname = rs.getString(2);
                                prixx = Integer.parseInt(rs.getString(3));
                                request.setAttribute("category", catfk);
                                request.setAttribute("prodname", pname);
                                request.setAttribute("price", prixx);
                            }

                            String sql500 = "insert into stocdatabase.product(catfk,productname,productmodel,productQuantity)  values (" + Integer.parseInt(request.getAttribute("category").toString()) + ",'" + request.getAttribute("prodname").toString() + "','" + request.getAttribute("prodmodel").toString() + "'," + Integer.parseInt(request.getAttribute("prodq2").toString()) + ")";
                            Statement stmt151 = c.createStatement();

                            stmt151.executeUpdate(sql500);

                            Statement stmt3 = c.createStatement();
                            ResultSet rs3 = stmt3.executeQuery("Select count(idproduct) from stocdatabase.product");

                            while (rs3.next()) {
                                counterpid = Integer.parseInt(rs3.getString(1));
                                request.setAttribute("pid1", counterpid);

                            }
                            String sssdw = request.getAttribute("pid1").toString();
                            int sedaserqw = Integer.parseInt(sssdw);
                            out.println(sedaserqw);

                            String sql121 = "insert into stocdatabase.stocpro(Stocid,prodid1)  values (" + Integer.parseInt(request.getAttribute("Sourcestock").toString()) + "," + sssdw + ")";

                            Statement stmt200 = c.createStatement();
                            stmt200.executeUpdate(sql121);

                        }

                    }

                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            }%>






    </body>
</html>
