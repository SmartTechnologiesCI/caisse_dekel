report 70029 "item - Top 10 List ext"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\RDLC\Report 70029 Palmarès articles.rdlc';
    ApplicationArea = Suite;
    Caption = 'Palmarès article';
    UsageCategory = ReportsAndAnalysis;
    //DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            //RequestFilterFields = "No.", "Vendor Posting Group", "Currency Code", "Date Filter";

            trigger OnAfterGetRecord()
            begin

                Window.Update(1, "No.");
                CalcFields("Purchases (LCY)", "Sales (LCY)");
                if ("Purchases (LCY)" = 0) and ("sales (LCY)" = 0) then
                    CurrReport.Skip();
                VendAmount.Init();
                VendAmount."Item No." := "No.";
                if ShowType = ShowType::"Purchases (LCY)" then begin
                    VendAmount."Amount" := -"Purchases (LCY)";
                    VendAmount."Amount 2" := -"sales (LCY)";
                end else begin
                    VendAmount."Amount" := -"sales (LCY)";
                    VendAmount."Amount 2" := -"Purchases (LCY)";
                end;
                VendAmount.Insert();
                if (NoOfRecordsToPrint = 0) or (i < NoOfRecordsToPrint) then
                    i := i + 1
                else begin
                    VendAmount.Find('+');
                    VendAmount.Delete();
                end;

                TotalVenPurchases += "Purchases (LCY)";
                TotalVenBalance += "sales (LCY)";
            end;

            trigger OnPreDataItem()
            var

            begin
                Window.Open(Text000);
                VendAmount.DeleteAll();
                i := 0;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(STRSUBSTNO_Text001_VendDateFilter_; StrSubstNo(Text001, VendDateFilter))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(STRSUBSTNO_Text002_SELECTSTR_ShowType_1_Text004__; StrSubstNo(Text002, SelectStr(ShowType + 1, Text004)))
            {
            }
            column(STRSUBSTNO___1___2__Vendor_TABLECAPTION_VendFilter_; StrSubstNo('%1: %2', Item.TableCaption, VendFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(STRSUBSTNO_Text003_SELECTSTR_ShowType_1_Text004__; StrSubstNo(Text003, SelectStr(ShowType + 1, Text004)))
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(Vendor__No__; Item."No.")
            {
            }
            column(Vendor_Name; Item.Description)
            {
            }
            column(Vente_Article; Item."Purchases (LCY)")
            {
            }
            column(Vendor__Balance__LCY__; Item."sales (LCY)")
            {
            }
            column(BarText; BarText)
            {
            }
            column(Vente_Article_Control23; Item."Purchases (LCY)")
            {
            }
            column(VendPurchLCY; VendPurchLCY)
            {
                AutoFormatType = 1;
            }
            column(PurchPct; PurchPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(TotalVenBalance; TotalVenBalance)
            {
            }
            column(TotalVenPurchases; TotalVenPurchases)
            {
            }
            column(Head; Head)
            {

            }
            column(Total; Total)
            {

            }
            column(TotalAchat; TotalAchat)
            {

            }
            column(TotalPercent; TotalPercent)
            {

            }
            column(DateDebutFilter; DateDebutFilter)
            {

            }
            column(DateFinFlter; DateFinFlter)
            {

            }
            column(TitreDiagramme; TitreDiagramme)
            {

            }


            column(CompagnieInfo_Img; CompagnieInfo.Picture) { }

            trigger OnAfterGetRecord()
            begin
                Head := 'Palamès Article';
                Total := 'Total';
                TotalAchat := 'TotalVente';
                TotalPercent := '% du Total Vente';


                if Number = 1 then begin
                    if not VendAmount.Find('-') then
                        CurrReport.Break();
                end else
                    if VendAmount.Next = 0 then
                        CurrReport.Break();
                VendAmount."Amount" := -VendAmount."Amount";
                Item.Get(VendAmount."Item No.");
                item.CalcFields("Purchases (LCY)", "Sales (LCY)");
                if MaxAmount = 0 then
                    MaxAmount := VendAmount."Amount";
                if (MaxAmount > 0) and (VendAmount."Amount" > 0) then
                    BarText := PadStr('', Round(VendAmount."Amount" / MaxAmount * 45, 1), '*')
                else
                    BarText := '';
                VendAmount."Amount" := -VendAmount."Amount";
            end;

            trigger OnPreDataItem()
            var
                // Records: Record Item;
            begin
                VendPurchLCY := Item."Purchases (LCY)";
                Window.Close;

                Item.SetRange("Date Filter", DateDebutFilter, DateFinFlter);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Show; ShowType)
                    {
                        ApplicationArea = Suite;
                        Caption = 'afficher';
                        OptionCaption = 'Vente';
                        ToolTip = 'Specifies how the report will sort the vendors: Purchases, to sort by purchase volume; or Balance, to sort by balance. In either case, the vendors with the largest amounts will be shown first.';
                    }
                    field(Quantity; NoOfRecordsToPrint)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Quantité';
                        ToolTip = 'Specifies the number of vendors that will be included in the report.';
                    }
                    field(DateDebutFilter; DateDebutFilter)
                    {
                        Caption = 'Date debut';
                    }
                    field(DateFinFlter; DateFinFlter)
                    {
                        Caption = 'Date Fin';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if NoOfRecordsToPrint = 0 then
                NoOfRecordsToPrint := 10;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompagnieInfo.CalcFields(Picture);
    end;

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        VendFilter := FormatDocument.GetRecordFiltersWithCaptions(Item);
        VendDateFilter := Item.GetFilter("Date Filter");
    end;


    var
        DateDebutFilter: Date;
        DateFinFlter: Date;
        Total: Text;
        TotalAchat: Text;
        TotalPercent: Text;
        TitreDiagramme: Label 'Les articles les plus vendus';
        Head: Text;
        Text000: Label 'Sorting vendors       #1##########';
        Text001: Label 'Periode: %1';
        CompagnieInfo: Record "Company Information";

        Text002: Label 'Classement par %1';
        Text003: Label 'Portion of %1';
        DDD: Record 321;
        VendAmount: Record "Item Amount" temporary;
        Window: Dialog;
        VendFilter: Text;
        VendDateFilter: Text;
        ShowType: Option "Purchases (LCY)","Balance (LCY)";
        NoOfRecordsToPrint: Integer;
        VendPurchLCY: Decimal;
        PurchPct: Decimal;
        MaxAmount: Decimal;
        BarText: Text[50];
        i: Integer;
        Text004: TextConst ENU = 'Purchases (LCY),Balance (LCY)', FRA = 'Vente';
        TotalVenPurchases: Decimal;
        TotalVenBalance: Decimal;
        Vendor___Top_10_ListCaptionLbl: Label 'Palmarès fournisseurs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Integer_NumberCaptionLbl: Label 'Rang';
        Vente_Article_Control23CaptionLbl: Label 'Total';
        VendPurchLCYCaptionLbl: Label 'Total Achats';
        PurchPctCaptionLbl: Label '% du Total achat';

    procedure InitializeRequest(NewShowType: Option; NewNoOfRecordsToPrint: Integer)
    begin
        ShowType := NewShowType;
        NoOfRecordsToPrint := NewNoOfRecordsToPrint;
    end;
}

