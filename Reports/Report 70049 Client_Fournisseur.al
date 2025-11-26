report 70049 Client_Fournisseur
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Rapport Quotidien Client Fournisseur';
    RDLCLayout = 'Reports\RDLC\Report Client_Fournisser.rdlc';

    dataset
    {
        dataitem("Item Weigh Bridge"; "Item Weigh Bridge")
        {
            RequestFilterFields = "Nom Client", "Type opération";
            column(Vehicle_Registration_No_; "Vehicle Registration No.")
            {

            }
            column(Date_validation; "Date validation")
            {

            }
            column(Weighing_2_Hour; "Weighing 2 Hour")
            {

            }
            column(Ticket_Planteur; "Ticket Planteur")
            {

            }
            column(POIDS_ENTREE; "POIDS ENTREE")
            {

            }
            column(POIDS_SORTIE; "POIDS SORTIE")
            {

            }
            column(POIDS_NET; "POIDS NET")
            {

            }
            column(Nom_Client; "Nom Client")
            {

            }
            column("Type_opération"; "Type opération")
            {

            }

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
                    // field()
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
}