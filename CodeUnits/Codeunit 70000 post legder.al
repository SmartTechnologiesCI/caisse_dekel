codeunit 70010 "Post Ledger"
{
    trigger OnRun()
    var
    begin

    end;




    procedure DeleteElements()
    var
        transactions: Record Transactions;
        depots: Record "Depôt";
        Mouvnt: Record "Mouvements Entrees Sorties";
        Encaissement: Record Encaissement;
        customer: Record Customer;
        salesHeader: Record "Sales Header";
        // silue samuel 07/03/2025 pesee: Record Pesse;

    begin

        IF transactions.FindFirst() THEN transactions.DeleteAll();
        IF depots.FindFirst() THEN depots.DeleteAll();
        ;
        IF Mouvnt.FindFirst() THEN Mouvnt.DeleteAll();
        ;
        IF Encaissement.FindFirst() THEN Encaissement.DeleteAll();
        IF customer.FindFirst() THEN customer.DeleteAll();
        salesHeader.SetFilter(Status, '=%1|%2', salesHeader.Status::Open, salesHeader.Status::Released);
        ;
        IF salesHeader.FindFirst() then
            salesHeader.DeleteAll();

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', true, true)]
    procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var
        myInt: Integer;
    begin
        HideDialog := true;
    end;

    var
        myInt: Integer;
}