#### Pagination Css

```bash
/* pagination */

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    list-style: none;
    padding-left: 0;
    gap: 6px;
}

.pagination li {
    display: inline-block;
}

.pagination .page-link {
    background-color: var(--theme-hover-bg);
    color: var(--text-color); /* light text */
    border: 1px solid var(--theme-color);
    padding: 8px 14px;
    border-radius: 8px;
    text-decoration: none;
    transition: all 0.2s ease-in-out;
    font-weight: 500;
}

/* Hover Effect */
.pagination .page-link:hover {
    background-color: transparent;
    color: var(--theme-color);
    border-color: var(--theme-color);
}

/* Active Page */
.pagination .active .page-link {
    background-color: var(--theme-color) !important;
    color: #ffffff !important;
    border-color: var(--theme-color) !important;
}

/* Disabled State */
.pagination .disabled .page-link {
    background-color: var(--theme-hover-bg);
    color: #6c757d;
    border-color: var(--theme-color);
    cursor: not-allowed;
    opacity: 0.6;
}

/* Optional: rounded “pill” style */
.pagination .page-item:first-child .page-link {
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
}
.pagination .page-item:last-child .page-link {
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
}


```
