page 70058 "ExpActivity"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ControllerCue;
    caption = 'Contrôle';
    layout
    {
        area(Content)
        {
            group("Activités")
            {
                cuegroup("Control & Liraisons")
                {
                    field("Non Payées"; Rec."Non Payées")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    /*field("Non payées partiel. livrées"; Rec."Non payées partiel. livrées")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }*/
                    /*field("Non payées totalement livrées"; Rec."Non payées totalement livrées")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }*/
                    field("Payées Non livrées"; Rec."Payées Non livrées")
                    {
                        ApplicationArea = All;
                        trigger ondrilldown()
                        var
                            myInt: Integer;
                            salesIvoiceHeader: Record "Sales Invoice Header";
                        begin
                            salesIvoiceHeader.Reset();
                            salesIvoiceHeader.SetRange(salesIvoiceHeader."Statut Livraison", salesIvoiceHeader."Statut Livraison"::"Payée Non livré");
                            salesIvoiceHeader.SetFilter("Document Date", '>=%1', DMY2Date(20, 4, 2021));
                            if salesIvoiceHeader.FindFirst() then begin
                                Page.Run(70071, salesIvoiceHeader);
                            end;

                        end;
                    }
                    field("Payées partiellement livrées"; Rec."Payées partiellement livrées")
                    {
                        ApplicationArea = All;
                        trigger ondrilldown()
                        var
                            myInt: Integer;
                            salesIvoiceHeader: Record "Sales Invoice Header";
                        begin
                            salesIvoiceHeader.Reset();
                            salesIvoiceHeader.SetRange(salesIvoiceHeader."Statut Livraison", salesIvoiceHeader."Statut Livraison"::"Payée partiellement livré");
                            salesIvoiceHeader.SetFilter("Document Date", '>=%1', DMY2Date(20, 4, 2021));
                            if salesIvoiceHeader.FindFirst() then begin
                                Page.Run(70071, salesIvoiceHeader);
                            end;
                        end;
                    }
                    field("Payées totalement livrées"; Rec."Payées totalement livrées")
                    {
                        ApplicationArea = All;
                        trigger ondrilldown()
                        var
                            myInt: Integer;
                            salesIvoiceHeader: Record "Sales Invoice Header";
                        begin
                            salesIvoiceHeader.Reset();
                            salesIvoiceHeader.SetRange(salesIvoiceHeader."Statut Livraison", salesIvoiceHeader."Statut Livraison"::"Payée totalement livré");
                            salesIvoiceHeader.SetFilter("Document Date", '>=%1', DMY2Date(20, 4, 2021));
                            if salesIvoiceHeader.FindFirst() then begin
                                Page.Run(70071, salesIvoiceHeader);
                            end;

                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Get() then begin
            Init();
            Insert();
            CurrPage.Update();
        end;
        rec.SetFilter(dateFilter, '>=%1', DMY2Date(20, 4, 2021));
    end;

    var
        myInt: Integer;
}