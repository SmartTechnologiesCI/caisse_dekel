report 70026 "Article vendu2"
{
    RDLCLayout = 'Reports\RDLC\Report 70026 Articles vendu.rdlc';
    Caption = 'Listes des articles vendu du jour';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            //RequestFilterFields = "order date";
            column(No_; "No.")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(CurrDateStart; CurrDateStart)
            {

            }
            column(CurrDateEnd; CurrDateEnd)
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Item_No_; "No.")
                {

                }
                column(Description; Description)
                {

                }

                column(Quantity; Quantity)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Cout_moyen; Cout_moyen)
                {

                }
                //silue samuel 07/03/2025 column(Carton_effectif; "Carton effectif") { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    tempCout: Decimal;
                    moyenCout: Decimal;

                begin
                    // silue samuel 07/03/2025 LigneArticle.Reset();
                    // LigneArticle.SetRange("N° article", "No.");

                    // if LigneArticle.FindFirst() then begin

                    //     repeat
                    //         Cout_moyen := LigneArticle."Coût de revient";
                    //         tempCout := tempCout + Cout_moyen;
                    //         myInt := myInt + 1;

                    //     until LigneArticle.Next = 0;
                    //     moyenCout := tempCout / myInt;
                    //     Cout_moyen := moyenCout;

                    // end;




                end;


            }
            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                SetRange("Order Date", CurrDateStart, CurrDateEnd);
                CalcFields(Cancelled);
                SetRange(Cancelled, false);

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

                field(CurrDateStart; CurrDateStart)
                {
                    Caption = 'Date Début';
                }
                field(CurrDateEnd; CurrDateEnd)
                {
                    Caption = 'Date Fin';
                }

            }
        }

        actions
        {

        }
        trigger OnOpenPage()
        var
            myInt: Integer;

            // silue samuel 07/03/2025 salesLine: Record "Sales Invoice Line";
        begin

            //CurrDateStart := DMY2Date(01, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
            CurrDateStart := WorkDate();
            CurrDateEnd := WorkDate();

            Date_Debut_Cout_moyen := DMY2Date(01, 01, Date2DMY(WorkDate(), 3));


        end;
    }
    var

        CurrDateStart: Date;
        CurrDateEnd: Date;
        Date_Debut_Cout_moyen: Date;
        Cout_moyen: Decimal;
        // LigneArticle: Record 50012;

}