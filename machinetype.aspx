﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMGT.master" AutoEventWireup="true" CodeFile="machinetype.aspx.cs" Inherits="machinetype" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row text-center">
        ADD MACHINE TYPES
    </div>
    <div class="pull-right">
        <h4 style="color:red;"><a href="machine.aspx">BACK</a></h4>
    </div>
    <div class="row" style="height:100px;">

    </div>
    <div class="row">
        <div class="col-lg-1"></div>
        <div class="col-lg-2">
            <asp:Label CssClass="label label-info" runat="server" ID="lblmac" Text="MACHINE TYPE"></asp:Label>
            <asp:TextBox ID="tbmac" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:CheckBox ID="cbeditop" runat="server" AutoPostBack="true" Text="EDIT OPERATIONS IN AN EXISTING MACHINE TYPE" OnCheckedChanged="cbeditop_CheckedChanged" />
            <asp:DropDownList ID="ddleditop" Enabled="false" AutoPostBack="true" runat="server" DataSourceID="sdsmtype" DataTextField="type" DataValueField="type" OnSelectedIndexChanged="ddleditop_SelectedIndexChanged"></asp:DropDownList>

        </div>
        <div class="col-lg-3">
            <asp:Label CssClass="label label-info" runat="server" ID="lblcmt" Text="CHOOSE OPERATIONS"></asp:Label>
            <asp:CheckBox ID="selectall" runat="server" Text="SELECT ALL" OnCheckedChanged="selectall_CheckedChanged" AutoPostBack="true" />
            <asp:CheckBoxList CssClass="checkbox checkbox-inline" ID="cblist" runat="server"  SelectMethod=""></asp:CheckBoxList>
        </div>
        <div class="col-lg-2">
            <asp:GridView ID="grtypemac" Width="500px" DataKeyNames="type" AutoGenerateDeleteButton="true" AutoGenerateColumns="false" CssClass="table table-hover table-responsive" runat="server" DataSourceID="sdsmtype" BorderStyle="Solid" Caption="CURRENT TYPES" CaptionAlign="Top" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                <AlternatingRowStyle BackColor="Snow" />
                <HeaderStyle Font-Bold="true" />
                <RowStyle Width="200px" />
                <Columns>
                    <asp:BoundField HeaderText="TYPE" DataField="type" />
                    <asp:TemplateField HeaderText="OPERATIONS"  ItemStyle-Width="500px" >
                        <ItemTemplate>
                            <div style="width:400px; overflow:hidden; white-space:nowrap;text-overflow:ellipsis;">
                            <%# Eval("phases") %>
                                </div>
                        </ItemTemplate>
                        
                    </asp:TemplateField>
                </Columns>
 
            </asp:GridView>
        </div>
        <div class="col-lg-2"></div>

    </div>
    <div class="row">
        <div class="col-lg-6">
            <asp:Button CssClass="center-block" ID="submittype" runat="server" OnClick="submittype_Click" Text="SUBMIT" />

        </div>
        <div class="col-lg-6">
        <asp:Button CssClass="center-block" ID="edittype" runat="server" OnClick="edittype_Click" Text="EDIT" Enabled="false" />

        </div>

    </div>
    <asp:SqlDataSource ID="sdsmtype" runat="server" ConnectionString='<%$ ConnectionStrings:automationConnectionString %>' DeleteCommand="DELETE FROM [machine-type] WHERE [type] = @type" InsertCommand="INSERT INTO [machine-type] ([type], [phases]) VALUES (@type, @phases)" SelectCommand="SELECT * FROM [machine-type]" UpdateCommand="UPDATE [machine-type] SET [phases] = @phases WHERE [type] = @type">
        <DeleteParameters>
            <asp:Parameter Name="type" Type="String"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="tbmac" Name="type" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="h1" Name="phases" PropertyName="Value" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="h1" Name="phases" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="ddleditop" Name="type" PropertyName="SelectedValue" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsoper" runat="server" ConnectionString='<%$ ConnectionStrings:automationConnectionString %>' SelectCommand="SELECT * FROM [phase] order by [phaseORDER]"></asp:SqlDataSource>
<asp:HiddenField ID="h1" runat="server" /> 
    <asp:SqlDataSource ID="reflectmac" runat="server" ConnectionString='<%$ ConnectionStrings:automationConnectionString %>' SelectCommand="SELECT * FROM [machine] WHERE ([mactype] = @mactype)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddleditop" PropertyName="SelectedValue" Name="mactype" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>   
    <asp:HiddenField ID="hiddenmac" runat="server" />
    <asp:SqlDataSource ID="reflectjob" runat="server" ConnectionString='<%$ ConnectionStrings:automationConnectionString %>' SelectCommand="SELECT * FROM [job] WHERE ([machineID] = @machineID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenmac" PropertyName="Value" Name="machineID" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>    
    <asp:HiddenField ID="hiddenjob" runat="server" />
    <asp:SqlDataSource ID="reflectplan" runat="server" ConnectionString='<%$ ConnectionStrings:automationConnectionString %>' DeleteCommand="DELETE FROM [plan] WHERE [job] = @job AND [phase] = @phase" InsertCommand="INSERT INTO [plan] ([job], [phase], [date]) VALUES (@job, @phase, @date)" SelectCommand="SELECT * FROM [plan] WHERE ([job] = @job) ORDER BY [phase]" UpdateCommand="UPDATE [plan] SET [date] = @date WHERE [job] = @job AND [phase] = @phase">
        <DeleteParameters>
            <asp:Parameter Name="job" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="phase" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="hiddenjob" Name="job" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hiddenphase" Name="phase" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hiddendate" Name="date" PropertyName="Value" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenjob" PropertyName="Value" Name="job" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="date" Type="String"></asp:Parameter>
            <asp:Parameter Name="job" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="phase" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenphase" runat="server" />
    <asp:HiddenField ID="hiddendate" runat="server" />
</asp:Content>
