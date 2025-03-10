report 70005 "Control Livraison"
{
    RDLCLayout = 'Reports\RDLC\Report 70005 Control livraison.rdlc';
    Caption = 'Etat control de livraison';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Statut Livraison";
            column(Date_Debut; Date_Debut)
            {

            }
            column(Date_fin; Date_fin)
            {

            }
            column(No_; "No.")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Statut_Livraison; "Statut Livraison")
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                RequestFilterFields = "Statut Livraison";
                column(Item_No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                // silue samuel 07/03/2025 column(Nombre_de_carton; "Carton effectif")
                // {

                // }
                column("Cartons_livrée"; "Qté livrée")
                {

                }
                // silue samuel 07/03/2025 column(reste; "Carton effectif" - "Qté livrée")
                // {

                // }
                column(Statut_Livraison_Line; "Statut Livraison")
                {

                }
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Order Date", Date_Debut, Date_Fin);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(Date_Debut; Date_Debut)
                {

                }
                field(Date_fin; Date_fin)
                {

                }
            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            Date_Debut := WorkDate();
            Date_fin := WorkDate();
        end;
    }

    var
        reste: Integer;
        Date_Debut: Date;
        Date_fin: Date;
}