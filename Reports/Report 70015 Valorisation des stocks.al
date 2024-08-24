report 70015 "Valorisation des stocks"
{
    RDLCLayout = 'Reports\RDLC\Report 70015 Valorisation des stocks.rdlc';
    Caption = 'Valorisation des stocks';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DataAccessIntent = ReadOnly;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem(Item; Item)
        {
            /*  column(ColumnName; SourceFieldName)
             {
                 DataItemLink = "Document No." = field("No.");
             } */

            RequestFilterFields = "No.";


            column(No_; "No.") { }
            column(Inventory; Poids) { }
            column(Carton_en_stock; Item."Cartons Solde") { }
            column(Description; Description) { }
            column(Unit_price; Unit_price) { }
            column(dateDebut; dateDebut) { }

            column(dateFin; dateFin) { }
            column(Prix_article; "Unit Price") { }



            trigger OnPreDataItem()
            var
                myInt: Integer;
                item: Record Item;


            begin




            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;


            begin

                /* item.SetRange("No.", SalesInvoiceLine."No.");
                Unit_price := SalesInvoiceLine."Unit Price"; */
                //Periode de valorisation
                SalesInvoiceLine.SetRange("No.", "No.");
                if (dateFin < DMY2Date(01, 04, 2021)) then begin
                    Error('La date doit etre superieur au 1er Avril 2021');
                    ;
                end else begin
                    Item.SetFilter(DateFilter, '%1..%2', dateDebut, dateFin);
                    Item.SetFilter(DateFilter2, '%1..%2', CreateDateTime(dateDebut, Tmp), CreateDateTime(dateFin, Tmp));
                    Item.CalcFields("Cartons Solde");
                    Item.CalcFields(Poids);
                    SalesInvoiceLine.SetRange("Posting Date", dateDebut, dateFin);
                end;
                ;





                if SalesInvoiceLine.FindFirst() then begin
                    Unit_price := SalesInvoiceLine."Unit Price";
                end;
                //Skip tout  les produits sans stock
                /*if Item.Inventory <= 0 then begin
                   CurrReport.Skip();
               end;
              if Item."Nombre cartons" <= 0 then
                   CurrReport.Skip();*/

                if Item.Blocked then
                    CurrReport.Skip();





            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                Description = 'Periode';
                group(Periode)
                {

                    /*  field(dateDebut; dateDebut)
                     {
                         Caption = 'Date debut';

                     } */
                    field(dateFin; dateFin)
                    {
                        Caption = 'Date fin';
                    }

                }
            }

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            dateDebut := DMY2Date(01, 04, 2021);
        end;
    }

    var
        myInt: Integer;
        Unit_price: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        dateDebut: Date;
        dateFin: Date;
        Tmp: Time;

}