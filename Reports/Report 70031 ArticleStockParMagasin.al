report 70043 "Article stock par magasins"
{
    Caption = 'Article stock par magasin';
    RDLCLayout = 'Reports\RDLC\Report 70031 ArticleStockParMagasin.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "Location Filter";
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Type; "Type")
            {
            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {
            }
            column(Inventory; Inventory)
            {
            }
            // column(Cartons_Solde; "Cartons Solde")
            // {
            // }
            column(Location_Filter; "locationFilter") { }
            // column(Marque; Marque) { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            ///locationFilter: Code[10];
            begin

                if Item.FindFirst() then begin
                    locationFilter := Item.GETFILTER("Location Filter");
                    // locationFilter :=   Item.GetFilter(field: any);
                    // locationFilter := "Location Filter";
                end;
            end;

            trigger OnAfterGetRecord()
            var
                bool: Boolean;

            begin
                bool := true;
                // locationFilter:= RequestFilterFields;
                if Inventory = 0 then begin
                    CurrReport.Skip
                end;
                if Blocked = bool then begin
                    CurrReport.Skip;
                end;
                


            end;


        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(magasin)
                {



                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        LocationFilter: Code[10];

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        // Clear(LocationFilter);

    end;
}
