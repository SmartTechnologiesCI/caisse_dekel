report 70048 Recu_Paiement
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Reçu Paiement';
    RDLCLayout = 'Reports\RDLC\Report 70048 Recu Paiement.rdlc';
    dataset
    {
        dataitem("Item Weigh Bridge"; "Item Weigh Bridge")
        {
            RequestFilterFields = "Ticket Planteur";
            column(Ticket_Planteur; "Ticket Planteur")
            {

            }
            column(Date_validation; "Date validation")
            {

            }
            column(Vehicle_Registration_No_; "Vehicle Registration No.")
            {

            }
            column(POIDS_NET; "POIDS NET")
            {

            }
            column(Prix; Prix)
            {

            }
            column(Picture; CompanyInfo.Picture)
            {

            }
            column(Item_Origin; "Item Origin")
            {

            }
            column()
            {
                
            }
            trigger OnPreDataItem()
            var
            begin
                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);

            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }



    var
        myInt: Integer;
        Prix: Decimal;
        CompanyInfo: Record "Company Information";
}